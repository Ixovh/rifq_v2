import 'package:flutter/material.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';

class AdoptionOptionSheet extends StatelessWidget {
  const AdoptionOptionSheet({
    super.key,
    required this.onAddNewPet,
    required this.onSelectMyPet,
  });

  final VoidCallback onAddNewPet;
  final VoidCallback onSelectMyPet;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Text(
              'Choose an option',
              style: context.body1,
            ),

            const SizedBox(height: 12),

            Text(
              'How would you like to list a pet for adoption?',
              textAlign: TextAlign.center,
              style: context.body2.copyWith(
                color: context.neutral600,
              ),
            ),

            const SizedBox(height: 28),

            Row(
              children: [
                Expanded(
                  child: _OptionButton(
                    title: 'Add new pet',
                    onTap: onAddNewPet,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _OptionButton(
                    title: 'Select from my pet',
                    onTap: onSelectMyPet,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionButton extends StatelessWidget {
  const _OptionButton({
    required this.title,
    required this.onTap,
  });

  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: context.primary50,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}