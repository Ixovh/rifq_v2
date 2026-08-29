enum LoadingState { initial, loading, success, error }

enum NetworkStatus { connected, disconnected, unknown }

enum StateLoadUser { local, remote }

enum AuthStatus { authenticated, unauthenticated, unknown }

enum OtpPurpose { signUp, resetPassword, emailChange }

enum BoardingTab { hotels, homeBoarding }

enum SortOption {
  recommended,
  nearest,
  topRated,
  lowestPrice,
  mostExperienced;

  String get label => switch (this) {
    SortOption.recommended => 'Recommended',
    SortOption.nearest => 'Nearest',
    SortOption.topRated => 'Top Rated',
    SortOption.lowestPrice => 'Lowest Price',
    SortOption.mostExperienced => 'Most Experienced',
  };
}

enum LanguagesEnum {
  ar,
  en;

  String get displayCode => name.toUpperCase();
  String get displayName {
    switch (name) {
      case 'ar':
        return "العربية";
      default:
        return "English";
    }
  }
}
