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

enum PaymentMethodOption {
  applePay,
  visa,
  mastercard;

  String get value => switch (this) {
    PaymentMethodOption.applePay => 'apple_pay',
    PaymentMethodOption.visa => 'visa',
    PaymentMethodOption.mastercard => 'mastercard',
  };

  String get label => switch (this) {
    PaymentMethodOption.applePay => 'Apple Pay',
    PaymentMethodOption.visa => 'Visa',
    PaymentMethodOption.mastercard => 'Mastercard',
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
