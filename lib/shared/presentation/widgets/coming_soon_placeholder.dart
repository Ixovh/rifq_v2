import 'package:flutter/material.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

/// Placeholder body for a bottom-nav tab whose screen hasn't been built yet.
class ComingSoonPlaceholder extends StatelessWidget {
  const ComingSoonPlaceholder({super.key, this.label = 'Coming soon'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      body: Center(
        child: Text(
          label,
          style: context.body1.copyWith(color: context.neutral600),
        ),
      ),
    );
  }
}
