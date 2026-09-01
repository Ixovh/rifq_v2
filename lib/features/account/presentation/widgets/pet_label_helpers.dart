import 'package:flutter/widgets.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';
import 'package:rifq_v2/l10n/generated/app_localizations.dart';
import 'package:rifq_v2/shared/presentation/widgets/app_pickers.dart';

/// Localized versions of [AccountPetEntity]'s display getters. The entity
/// lives in `domain/` and can't reach `AppLocalizations`, so the same
/// month/year and unit formatting is done here off its raw fields.

String petAgeLabel(BuildContext context, AccountPetEntity pet) {
  final l10n = AppLocalizations.of(context)!;
  final dob = pet.birthdate;
  if (dob != null) {
    final now = DateTime.now();
    var months = (now.year - dob.year) * 12 + now.month - dob.month;
    if (now.day < dob.day) months--;
    if (months < 0) months = 0;
    if (months < 12) return l10n.pet_ageMonths(months < 1 ? 1 : months);
    return l10n.pet_ageYears(months ~/ 12);
  }

  final age = pet.age;
  if (age == null) return '-';
  if (age < 1) return l10n.pet_ageMonths(1);
  return l10n.pet_ageYears(age);
}

String petWeightLabel(BuildContext context, AccountPetEntity pet) {
  final weight = pet.weight;
  if (weight == null) return '-';
  final text = weight == weight.roundToDouble()
      ? weight.toInt().toString()
      : weight.toStringAsFixed(1);
  return AppLocalizations.of(context)!.common_weightKg(text);
}

String petSpeciesLabel(BuildContext context, AccountPetEntity pet) =>
    pet.species.isEmpty ? '-' : speciesLabel(context, pet.species);

String petGenderLabel(BuildContext context, String gender) {
  final l10n = AppLocalizations.of(context)!;
  switch (gender.toLowerCase()) {
    case 'male':
      return l10n.common_genderMale;
    case 'female':
      return l10n.common_genderFemale;
    default:
      return gender.isEmpty
          ? '-'
          : gender[0].toUpperCase() + gender.substring(1);
  }
}
