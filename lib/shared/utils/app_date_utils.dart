import 'package:rifq_v2/l10n/generated/app_localizations.dart';

class AppDateUtils {
  AppDateUtils._();

  static String formatAge(DateTime birthdate, AppLocalizations l10n) {
    final now = DateTime.now();

    int years = now.year - birthdate.year;

    if (now.month < birthdate.month ||
        (now.month == birthdate.month &&
            now.day < birthdate.day)) {
      years--;
    }

    if (years <= 0) {
      final months =
          (now.year - birthdate.year) * 12 +
          now.month -
          birthdate.month;

      if (months <= 0) {
        return l10n.pet_ageLessThanOneMonth;
      }

      return l10n.pet_ageMonths(months);
    }

    return l10n.pet_ageYears(years);
  }
}
