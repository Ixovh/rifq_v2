import 'package:flutter/material.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class AdoptionHeader extends StatelessWidget {
  const AdoptionHeader({
    super.key,
    this.onNotificationTap,
  });

  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withValues(
                alpha: 0.12,
              ),
              border: Border.all(
                color: colorScheme.primary.withValues(
                  alpha: 0.4,
                ),
              ),
            ),
            alignment: Alignment.center,
            child: Text(
              'S',
              style: TextStyle(
                color: context.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const Spacer(),

          Text(
            'Adoption',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: context.primary50
                ),
          ),

          const Spacer(),

          IconButton(
            onPressed: onNotificationTap,
            icon: Icon(
              Icons.notifications_none_rounded,
            color: context.primary50
            ),
          ),
        ],
      ),
    );
  }
}