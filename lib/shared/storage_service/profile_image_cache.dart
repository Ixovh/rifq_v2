import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

/// Compresses profile photos and keeps a local copy per user so avatars
/// can load without waiting on the network.
class ProfileImageCache {
  ProfileImageCache._();

  static final _box = GetStorage();
  static const _keyPrefix = 'profile_image_cache_';

  static String _key(String userId) => '$_keyPrefix$userId';

  static String canonicalUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) return url;
    return '${uri.scheme}://${uri.authority}${uri.path}';
  }

  static File? localFile({required String userId, required String imageUrl}) {
    final data = _box.read(_key(userId));
    if (data is! Map) return null;
    final cachedUrl = data['url'] as String?;
    final path = data['path'] as String?;
    if (cachedUrl == null || path == null) return null;
    if (canonicalUrl(cachedUrl) != canonicalUrl(imageUrl)) return null;
    final file = File(path);
    if (!file.existsSync()) return null;
    return file;
  }

  static Future<File> compress(File input) async {
    final tempDir = await getTemporaryDirectory();
    final targetPath =
        '${tempDir.path}/profile_${DateTime.now().millisecondsSinceEpoch}.jpg';
    try {
      final result = await FlutterImageCompress.compressAndGetFile(
        input.path,
        targetPath,
        quality: 70,
        minWidth: 720,
        minHeight: 720,
        format: CompressFormat.jpeg,
      );
      if (result == null) return input;
      return File(result.path);
    } catch (_) {
      return input;
    }
  }

  static Future<File> save({
    required String userId,
    required File file,
    required String imageUrl,
  }) async {
    final docs = await getApplicationDocumentsDirectory();
    final folder = Directory('${docs.path}/profile_images');
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }
    final dest = File('${folder.path}/$userId.jpg');
    if (file.path != dest.path) {
      await file.copy(dest.path);
    }
    await _box.write(_key(userId), {
      'url': canonicalUrl(imageUrl),
      'path': dest.path,
    });
    return dest;
  }

  static Future<File?> downloadAndSave({
    required String userId,
    required String imageUrl,
  }) async {
    final cached = localFile(userId: userId, imageUrl: imageUrl);
    if (cached != null) return cached;

    final uri = Uri.parse(imageUrl);
    final bustUrl = uri
        .replace(
          queryParameters: {
            ...uri.queryParameters,
            't': DateTime.now().millisecondsSinceEpoch.toString(),
          },
        )
        .toString();

    final response = await Dio().get<List<int>>(
      bustUrl,
      options: Options(responseType: ResponseType.bytes),
    );
    final bytes = response.data;
    if (bytes == null || bytes.isEmpty) return null;

    final tempDir = await getTemporaryDirectory();
    final tempFile = File(
      '${tempDir.path}/profile_dl_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    await tempFile.writeAsBytes(bytes, flush: true);
    final compressed = await compress(tempFile);
    return save(userId: userId, file: compressed, imageUrl: imageUrl);
  }

  static Future<void> clear(String userId) async {
    final data = _box.read(_key(userId));
    if (data is Map) {
      final path = data['path'] as String?;
      if (path != null) {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
        }
      }
    }
    await _box.remove(_key(userId));
  }
}
