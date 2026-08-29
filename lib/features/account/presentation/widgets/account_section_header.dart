import 'package:flutter/material.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class AccountSectionHeader extends StatelessWidget {
  const AccountSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: context.body1.copyWith(color: context.neutral1000)),
        const Spacer(),
        if (actionLabel != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              actionLabel!,
              style: context.body3.copyWith(color: context.neutral600),
            ),
          ),
      ],
    );
  }
}
