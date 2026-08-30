import 'package:flutter/material.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

/// Placeholder body for a bottom-nav tab whose screen hasn't been built yet.
class ComingSoonPlaceholder extends StatelessWidget {
  const ComingSoonPlaceholder({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.background,
      body: Center(
        child: Text(
          label ?? AppLocalizations.of(context)!.common_comingSoon,
          style: context.body1.copyWith(color: context.neutral600),
        ),
      ),
    );
  }
}
