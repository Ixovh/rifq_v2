class AppDateUtils {
  AppDateUtils._();

  static String formatAge(DateTime birthdate) {
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
        return 'Less than 1 month';
      }

      return months == 1 ? '1 month' : '$months months';
    }

    return years == 1 ? '1 year' : '$years years';
  }
}