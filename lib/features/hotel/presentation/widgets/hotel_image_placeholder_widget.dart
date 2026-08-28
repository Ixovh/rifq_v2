import 'package:flutter/material.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

/// Icon-based fallback for a missing/broken hotel photo. `AppImages` has no
/// actual placeholder asset shipped in assets/images/ (the constant points
/// at a file that was never added), so this avoids depending on it.
class HotelImagePlaceholder extends StatelessWidget {
  const HotelImagePlaceholder({super.key, this.iconSize});

  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.neutral100,
      child: Center(
        child: Icon(
          Icons.hotel_outlined,
          size: iconSize,
          color: context.neutral400,
        ),
      ),
    );
  }
}
