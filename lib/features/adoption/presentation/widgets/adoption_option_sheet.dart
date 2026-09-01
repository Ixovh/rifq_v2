import 'package:flutter/material.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
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
              l10n.adoption_chooseOption,
              style: context.body1,
            ),

            const SizedBox(height: 12),

            Text(
              l10n.adoption_chooseOptionSubtitle,
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
                    title: l10n.adoption_addNewPet,
                    onTap: onAddNewPet,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _OptionButton(
                    title: l10n.adoption_selectFromMyPets,
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