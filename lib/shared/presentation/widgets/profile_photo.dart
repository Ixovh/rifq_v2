import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
import 'package:rifq_v2/shared/storage_service/profile_image_cache.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({
    super.key,
    required this.diameter,
    this.imageUrl,
    this.localPreview,
    required this.fallback,
    this.backgroundColor,
    this.border,
  });

  final double diameter;
  final String? imageUrl;
  final File? localPreview;
  final Widget fallback;
  final Color? backgroundColor;
  final BoxBorder? border;

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  File? _cachedFile;
  var _loading = false;

  @override
  void initState() {
    super.initState();
    _applySyncState();
    _downloadIfNeeded();
  }

  @override
  void didUpdateWidget(covariant ProfilePhoto oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl ||
        oldWidget.localPreview?.path != widget.localPreview?.path) {
      setState(_applySyncState);
      _downloadIfNeeded();
    }
  }

  void _applySyncState() {
    if (widget.localPreview != null) {
      _cachedFile = widget.localPreview;
      _loading = false;
      return;
    }

    final url = widget.imageUrl;
    if (url == null || url.isEmpty) {
      _cachedFile = null;
      _loading = false;
      return;
    }

    final userId = AuthHelper.getUserId();
    if (userId != null) {
      final local = ProfileImageCache.localFile(userId: userId, imageUrl: url);
      if (local != null) {
        _cachedFile = local;
        _loading = false;
        return;
      }
    }

    _cachedFile = null;
    _loading = true;
  }

  Future<void> _downloadIfNeeded() async {
    if (!_loading) return;
    final url = widget.imageUrl;
    final userId = AuthHelper.getUserId();
    if (url == null || url.isEmpty || userId == null) {
      if (mounted) setState(() => _loading = false);
      return;
    }

    try {
      final file = await ProfileImageCache.downloadAndSave(
        userId: userId,
        imageUrl: url,
      );
      if (!mounted) return;
      if (widget.imageUrl != url) return;
      setState(() {
        _cachedFile = file;
        _loading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageFile = widget.localPreview ?? _cachedFile;
    final hasFile = imageFile != null;
    final hasNetwork =
        !hasFile && widget.imageUrl != null && widget.imageUrl!.isNotEmpty;

    Widget child;
    if (_loading && !hasFile) {
      child = _ShimmerCircle(diameter: widget.diameter);
    } else if (hasFile) {
      child = Image.file(
        imageFile,
        width: widget.diameter,
        height: widget.diameter,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => widget.fallback,
      );
    } else if (hasNetwork) {
      child = Image.network(
        widget.imageUrl!,
        width: widget.diameter,
        height: widget.diameter,
        fit: BoxFit.cover,
        loadingBuilder: (context, image, progress) {
          if (progress == null) return image;
          return _ShimmerCircle(diameter: widget.diameter);
        },
        errorBuilder: (_, _, _) => widget.fallback,
      );
    } else {
      child = Center(child: widget.fallback);
    }

    return Container(
      width: widget.diameter,
      height: widget.diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.backgroundColor ?? context.primary100,
        border: widget.border,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

class _ShimmerCircle extends StatelessWidget {
  const _ShimmerCircle({required this.diameter});

  final double diameter;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child:
          Container(
                width: diameter,
                height: diameter,
                color: context.neutral300,
              )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 1100.ms, color: context.neutral100),
    );
  }
}
