import 'package:flutter/material.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/extensions/context_theme_extension.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_pickers.dart';

class MyPetsSelectionSheet extends StatelessWidget {
  const MyPetsSelectionSheet({
    super.key,
    required this.pets,
    required this.onPetSelected,
  });

  final List<Map<String, dynamic>> pets;
  final ValueChanged<Map<String, dynamic>> onPetSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Text(
                  l10n.adoption_whichPet,
                  style: context.body1.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Spacer(),

                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(
                    Icons.close,
                    color: context.neutral1000,
                    size: 28,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Text(
              l10n.adoption_choosePetToList,
              style: context.body2.copyWith(
                color: context.neutral600,
              ),
            ),

            const SizedBox(height: 28),

            if (pets.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 35),
                  child: Column(
                    children: [
                      Icon(
                        Icons.pets,
                        size: 55,
                        color: context.neutral500,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        l10n.adoption_noPetsToSelect,
                        style: context.body2.copyWith(
                          color: context.neutral600,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              SizedBox(
                height: 190,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: pets.length,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: 22),
                  itemBuilder: (context, index) {
                    final pet = pets[index];

                    return _PetItem(
                      pet: pet,
                      onTap: () => onPetSelected(pet),
                    );
                  },
                ),
              ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _PetItem extends StatelessWidget {
  const _PetItem({
    required this.pet,
    required this.onTap,
  });

  final Map<String, dynamic> pet;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final name = pet['name']?.toString() ?? '';
    final species = pet['species']?.toString() ?? '';
    final photoUrl = pet['photo_url']?.toString();

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 115,
        child: Column(
          children: [
            // Pet image
            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.primary50,
                border: Border.all(
                  color: context.neutral300,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.12),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: photoUrl != null && photoUrl.isNotEmpty
                    ? Image.network(
                        photoUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return Icon(
                            Icons.pets,
                            size: 42,
                            color: context.primary300,
                          );
                        },
                      )
                    : Icon(
                        Icons.pets,
                        size: 42,
                        color: context.primary300,
                      ),
              ),
            ),

            const SizedBox(height: 10),

            // Pet name
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.body1.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 3),

            // Species
            Text(
              species.isEmpty ? species : speciesLabel(context, species),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: context.body2.copyWith(
                color: context.neutral600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}