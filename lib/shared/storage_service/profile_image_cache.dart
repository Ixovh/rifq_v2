import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';

/// Compresses photos and keeps a local copy per user **and per image URL** so
/// avatars and pet photos can load without waiting on the network.
///
/// Each URL gets its own file (`<userId>_<urlHash>.jpg`), so caching a pet
/// photo can never overwrite the user's profile picture (they only shared a
/// single `<userId>.jpg` slot before, which made the avatar flip to the last
/// downloaded pet image).
class ProfileImageCache {
  ProfileImageCache._();

  static final _box = GetStorage();

  /// v2: value is a map of canonicalUrl -> local file path.
  static const _keyPrefix = 'profile_image_cache_v2_';

  /// Legacy single-entry key ({url, path}); only used for cleanup.
  static const _legacyKeyPrefix = 'profile_image_cache_';

  static String _key(String userId) => '$_keyPrefix$userId';

  static String canonicalUrl(String url) {
    final uri = Uri.tryParse(url);
    if (uri == null || !uri.hasScheme) return url;
    return '${uri.scheme}://${uri.authority}${uri.path}';
  }

  /// Stable FNV-1a hash so the same URL maps to the same file across runs.
  static String _urlHash(String canonical) {
    var hash = 0x811c9dc5;
    for (final unit in canonical.codeUnits) {
      hash ^= unit;
      hash = (hash * 0x01000193) & 0xFFFFFFFF;
    }
    return hash.toRadixString(16).padLeft(8, '0');
  }

  static Map<String, String> _entries(String userId) {
    final data = _box.read(_key(userId));
    if (data is! Map) return {};
    return data.map((k, v) => MapEntry(k.toString(), v.toString()));
  }

  static File? localFile({required String userId, required String imageUrl}) {
    final path = _entries(userId)[canonicalUrl(imageUrl)];
    if (path == null) return null;
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

    final canonical = canonicalUrl(imageUrl);
    final dest = File('${folder.path}/${userId}_${_urlHash(canonical)}.jpg');
    if (file.path != dest.path) {
      await file.copy(dest.path);
    }

    final entries = _entries(userId);
    entries[canonical] = dest.path;
    await _box.write(_key(userId), entries);
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

  /// Removes every cached image file and metadata entry for [userId],
  /// including any leftovers from the legacy single-file format.
  static Future<void> clear(String userId) async {
    for (final path in _entries(userId).values) {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    }
    await _box.remove(_key(userId));

    // Legacy cleanup: old format stored {url, path} under a different key
    // and a shared <userId>.jpg file.
    final legacy = _box.read('$_legacyKeyPrefix$userId');
    if (legacy is Map) {
      final path = legacy['path'] as String?;
      if (path != null) {
        final file = File(path);
        if (await file.exists()) {
          await file.delete();
        }
      }
    }
    await _box.remove('$_legacyKeyPrefix$userId');
  }
}
