import 'package:flutter/material.dart';

/// Back chevron that points toward the trailing/"forward" side in RTL and
/// toward the leading side in LTR.
///
/// [Icons.arrow_back_ios_new] / [Icons.arrow_forward_ios] both set
/// [IconData.matchTextDirection], so painting under ambient RTL would flip
/// them again. We pick the glyph for the locale, then force LTR painting so
/// the chosen direction sticks.
class AppBackIcon extends StatelessWidget {
  const AppBackIcon({super.key, this.color, this.size});

  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Icon(
      isRtl ? Icons.arrow_forward_ios : Icons.arrow_back_ios_new,
      color: color,
      size: size,
      textDirection: TextDirection.ltr,
    );
  }
}
