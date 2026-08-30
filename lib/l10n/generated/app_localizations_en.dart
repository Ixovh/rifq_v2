// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get common_retry => 'Retry';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get common_save => 'Save';

  @override
  String get common_next => 'Next';

  @override
  String get common_goBack => 'Go back';

  @override
  String get common_continue => 'Continue';

  @override
  String get common_done => 'Done';

  @override
  String get common_confirm => 'Confirm';

  @override
  String get common_apply => 'Apply';

  @override
  String get common_reset => 'Reset';

  @override
  String get common_comingSoon => 'Coming soon';

  @override
  String get common_seeAll => 'See all';

  @override
  String get common_yourPets => 'Your Pets';

  @override
  String get common_email => 'Email';

  @override
  String get common_password => 'Password';

  @override
  String get common_name => 'Name';

  @override
  String get common_firstName => 'First Name';

  @override
  String get common_lastName => 'Last Name';

  @override
  String get common_phoneNumber => 'Phone number';

  @override
  String get common_nameRequired => 'Name is required';

  @override
  String get common_invalidEmail => 'Enter a valid email address';

  @override
  String get common_gender => 'Gender';

  @override
  String get common_age => 'Age';

  @override
  String get common_breed => 'Breed';

  @override
  String get common_genderMale => 'Male';

  @override
  String get common_genderFemale => 'Female';

  @override
  String get common_userFallback => 'User';

  @override
  String get common_chooseDate => 'Choose Date';

  @override
  String get common_chooseDateTitle => 'Choose date';

  @override
  String get common_chooseDatesTitle => 'Choose dates';

  @override
  String get common_setTimeTitle => 'Set time';

  @override
  String get common_chooseDateOfBirth => 'Choose date of birth';

  @override
  String get common_couldNotPickImage => 'Could not pick image';

  @override
  String get common_chooseFromGallery => 'Choose from gallery';

  @override
  String get common_takePhoto => 'Take a photo';

  @override
  String get common_removePhoto => 'Remove photo';

  @override
  String get common_searchHint => 'Search...';

  @override
  String get common_date => 'Date';

  @override
  String common_reviewsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '($count reviews)',
      one: '(1 review)',
    );
    return '$_temp0';
  }

  @override
  String common_yearsExpShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count yrs exp.',
      one: '1 yr exp.',
    );
    return '$_temp0';
  }

  @override
  String common_pricePerNightSar(String price) {
    return 'SAR $price / night';
  }

  @override
  String common_weightKg(String value) {
    return '$value kg';
  }

  @override
  String common_locationDistance(String location, String distance) {
    return '$location — $distance km';
  }

  @override
  String pet_ageMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count months',
      one: '1 month',
    );
    return '$_temp0';
  }

  @override
  String pet_ageYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Years',
      one: '1 Year',
    );
    return '$_temp0';
  }

  @override
  String get species_cat => 'Cat';

  @override
  String get species_dog => 'Dog';

  @override
  String get species_bird => 'Bird';

  @override
  String get species_falcon => 'Falcon';

  @override
  String get species_rabbit => 'Rabbit';

  @override
  String get species_fish => 'Fish';

  @override
  String get species_turtle => 'Turtle';

  @override
  String get species_hamster => 'Hamster';

  @override
  String get species_pigeon => 'Pigeon';

  @override
  String get species_horse => 'Horse';

  @override
  String get species_other => 'Other';

  @override
  String get welcome_title => 'Welcome to Rifq';

  @override
  String get welcome_subtitle =>
      'Your trusted space for pet care and services.';

  @override
  String get welcome_signInPrompt => 'Sign in to continue caring with ease.';

  @override
  String get welcome_signIn => 'Sign in';

  @override
  String get welcome_continueGuest => 'Continue as Guest';

  @override
  String get choosePath_subtitle => 'making pet care simple for everyone';

  @override
  String get choosePath_prompt => 'Choose your path to start:';

  @override
  String get choosePath_petOwner => 'I own a pet';

  @override
  String get choosePath_serviceProvider => 'I provide care services';

  @override
  String get onboarding_title1 => 'Welcome to Rifq!';

  @override
  String get onboarding_title2 => 'Track Your Pet’s \n Health Easily';

  @override
  String get onboarding_title3 => 'Smart Care, Anytime';

  @override
  String get onboarding_subtitle1 =>
      'Your all-in-one app for caring, tracking,\n and supporting every moment of your \n pet’s life.';

  @override
  String get onboarding_subtitle2 =>
      'Keep all medical records, vaccinations,\n and check-ups organized in one smart \n health card.';

  @override
  String get onboarding_subtitle3 =>
      'Use AI to check symptoms,\n find nearby clinics, home services, \n hotels, and everything your pet needs.';

  @override
  String get onboarding_getStarted => 'Get started';

  @override
  String get onboarding_skip => 'Skip';

  @override
  String get auth_loginTab => 'Log in';

  @override
  String get auth_signupTab => 'Sign up';

  @override
  String get auth_loginPrompt => 'Please enter your email and password.';

  @override
  String get auth_signupPrompt => 'Please fill in your details to continue.';

  @override
  String get auth_emailHintError => '(e.g., username@example.com).';

  @override
  String get auth_passwordError => 'Incorrect password. Please try again.';

  @override
  String get auth_passwordRule =>
      'Includes at least one number or symbol (e.g., @, #, \$, !).';

  @override
  String get auth_forgotPassword => 'Forgot password?';

  @override
  String get auth_loginButton => 'Log in';

  @override
  String get auth_signupButton => 'Sign up';

  @override
  String get auth_verifyButton => 'Verify';

  @override
  String get auth_agreePrefix => 'By continuing, you agree to our ';

  @override
  String get auth_termsAndConditions => 'Terms & Conditions ';

  @override
  String get auth_agreeAnd => 'and ';

  @override
  String get auth_privacyPolicy => 'Privacy Policy';

  @override
  String get auth_resetPasswordTitle => 'Reset Password';

  @override
  String get auth_resetPasswordPrompt =>
      'Please enter your new password to proceed.';

  @override
  String get auth_sendEmailPrompt =>
      'Enter your email to verify and reset your password.';

  @override
  String get otp_confirmNewEmailTitle => 'Confirm New Email';

  @override
  String get otp_emailVerificationTitle => 'Email Verification';

  @override
  String get otp_emailUpdated => 'Email updated successfully';

  @override
  String get otp_sentAgain => 'OTP sent again';

  @override
  String get otp_sentNewEmailBody =>
      'We have sent an OTP to your new email address';

  @override
  String get otp_sentEmailBody => 'We have sent an OTP to your email address';

  @override
  String get otp_enterBelow => 'Please enter the OTP below';

  @override
  String otp_resendCodeIn(String time) {
    return 'Resend code in $time';
  }

  @override
  String get otp_sending => 'Sending...';

  @override
  String get otp_resend => 'Resend OTP';

  @override
  String get nav_askAi => 'Ask AI';

  @override
  String get nav_home => 'Home';

  @override
  String get nav_health => 'Health';

  @override
  String get nav_hotel => 'Hotel';

  @override
  String get nav_adoption => 'Adoption';

  @override
  String get home_quickService => 'Quick Service';

  @override
  String get home_clinicVisit => 'Clinic Visit';

  @override
  String get home_petHotel => 'Pet Hotel';

  @override
  String get home_adopt => 'Adopt';

  @override
  String get home_recommendations => 'Recommendations';

  @override
  String get home_welcome => 'Welcome';

  @override
  String get home_helloPrefix => 'Hello, ';

  @override
  String get home_addPet => 'Add Pet';

  @override
  String get account_securityPrivacy => 'Security & Privacy';

  @override
  String get account_language => 'Language';

  @override
  String get account_logout => 'Log out';

  @override
  String get account_logoutConfirmMessage =>
      'Are you sure you want to log out?';

  @override
  String get account_noPetsYet => 'No pets yet';

  @override
  String get account_listedForAdoption => 'Listed for Adoption';

  @override
  String get account_phoneRequired => 'Phone number is required';

  @override
  String get account_phoneInvalid9 => 'Enter a valid 9-digit phone number';

  @override
  String get account_selectCountry => 'Select country';

  @override
  String get account_searchCountry => 'Search by name or code';

  @override
  String get account_noCountriesFound => 'No countries found';

  @override
  String get editProfile_title => 'Edit Profile';

  @override
  String get editProfile_otpSentNewEmail => 'We sent an OTP to your new email';

  @override
  String get editProfile_profileUpdated => 'Profile updated';

  @override
  String get editProfile_signInToEdit => 'Sign in to edit profile';

  @override
  String get editProfile_firstNameRequired => 'First name is required';

  @override
  String get editProfile_emailRequired => 'Email is required';

  @override
  String get petProfile_title => 'Pet Profile';

  @override
  String get petProfile_tabHealthRecord => 'Health Record';

  @override
  String get petProfile_tabAppointment => 'Appointment';

  @override
  String get petProfile_noAppointments => 'No Appointments Yet';

  @override
  String get addPet_title => 'Add Your Pet';

  @override
  String get addPet_success => 'Pet added successfully';

  @override
  String get addPet_completeAllFields => 'Please complete all fields';

  @override
  String get addPet_profileNotFound => 'User profile not found';

  @override
  String get addPet_uploadPhoto => 'Upload your pet\'s photo';

  @override
  String get addPet_nameQuestion => 'What\'s your pet\'s name?';

  @override
  String get addPet_nameHint => 'Mila';

  @override
  String get addPet_genderQuestion => 'What\'s your pet\'s gender?';

  @override
  String get addPet_ageQuestion => 'What\'s your pet\'s age?';

  @override
  String get addPet_typeQuestion => 'What type of pet do you have?';

  @override
  String get addPet_breedQuestion => 'What\'s your pet\'s breed?';

  @override
  String get addPet_breedHint => 'Husky';

  @override
  String addPet_ageValue(String age) {
    return 'Age: $age';
  }

  @override
  String get editPet_title => 'Edit Pet';

  @override
  String get editPet_updated => 'Pet updated';

  @override
  String get editPet_nameLabel => 'Pet\'s Name';

  @override
  String get editPet_breedLabel => 'Pet\'s breed';

  @override
  String get editPet_breedRequired => 'Breed is required';

  @override
  String get editPet_weightLabel => 'Pet\'s weight';

  @override
  String get editPet_ageLabel => 'Pet\'s age';

  @override
  String get editPet_ageRequired => 'Pet age is required';

  @override
  String get editPet_invalidWeight => 'Enter a valid weight';

  @override
  String get healthRecord_chooseVisitDate => 'Choose date of visit';

  @override
  String get healthRecord_visitDateRequired => 'Please choose a visit date';

  @override
  String get healthRecord_saved => 'Health record saved';

  @override
  String get healthRecord_addTitle => 'Add Health Record';

  @override
  String get healthRecord_fieldTitle => 'Title';

  @override
  String get healthRecord_titleRequired => 'Title is required';

  @override
  String get healthRecord_fieldType => 'Type';

  @override
  String get healthRecord_typeRequired => 'Type is required';

  @override
  String get healthRecord_fieldDescription => 'Description';

  @override
  String get healthRecord_fieldClinic => 'Clinic Name';

  @override
  String get healthRecord_saveRecord => 'Save Record';

  @override
  String get healthRecord_dateOfVisit => 'Date of Visit';

  @override
  String get healthRecord_empty => 'No Health Record Yet';

  @override
  String get healthRecord_addNew => 'Add new health record';

  @override
  String get hotel_screenTitle => 'Hotel';

  @override
  String get hotel_bookNow => 'Book Now';

  @override
  String get hotel_tabHotels => 'Hotels';

  @override
  String get hotel_tabHomeBoarding => 'Home Boarding';

  @override
  String get hotel_tabRooms => 'Rooms';

  @override
  String get hotel_tabInfo => 'Hotel Info';

  @override
  String get hotel_noRooms => 'No rooms listed for this hotel yet.';

  @override
  String get hotel_otherServices => 'Other Services';

  @override
  String get hotel_aboutTitle => 'About the Hotel';

  @override
  String get hotel_noDescription => 'No description available yet.';

  @override
  String get hotel_facilities => 'Facilities';

  @override
  String get hotel_rulesTitle => 'Rules & Requirements';

  @override
  String get hotel_location => 'Location';

  @override
  String get hotel_servicesLabel => 'Services : ';

  @override
  String get hotel_includesLabel => 'Includes :';

  @override
  String get hotel_priceUnavailable => 'Price unavailable';

  @override
  String get hotel_sortFilterTitle => 'Sort & Filter';

  @override
  String get hotel_emptyHotels =>
      'No hotels available right now — check back soon.';

  @override
  String get hotel_emptySitters =>
      'No sitters available right now — check back soon.';

  @override
  String get hotel_errorLoadingHotels =>
      'Something went wrong loading hotels. Please try again.';

  @override
  String hotel_startingPrice(String price) {
    return 'Start from $price SAR/night';
  }

  @override
  String hotel_locationDistance(String location, String distance) {
    return '$location – $distance km';
  }

  @override
  String hotel_servicePrice(String name, String price) {
    return '$name : SAR $price';
  }

  @override
  String hotel_roomsTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rooms total',
      one: '1 room total',
    );
    return '$_temp0';
  }

  @override
  String get sortOption_recommended => 'Recommended';

  @override
  String get sortOption_nearest => 'Nearest';

  @override
  String get sortOption_topRated => 'Top Rated';

  @override
  String get sortOption_lowestPrice => 'Lowest Price';

  @override
  String get sortOption_mostExperienced => 'Most Experienced';

  @override
  String get homeBoarding_contact => 'Contact';

  @override
  String get homeBoarding_about => 'About';

  @override
  String get homeBoarding_skills => 'Skills';

  @override
  String get homeBoarding_requestPending => 'Request Pending';

  @override
  String get homeBoarding_sendRequest => 'Send Request';

  @override
  String get homeBoarding_requestSentTitle => 'Request Sent!';

  @override
  String get homeBoarding_requestSentBody =>
      'Your home boarding request has been sent to the host.';

  @override
  String get homeBoarding_backToHome => 'Back to Home';

  @override
  String get homeBoarding_errorChecking =>
      'Something went wrong checking your requests. Please try again.';

  @override
  String get homeBoarding_errorSending =>
      'Something went wrong sending your request. Please try again.';

  @override
  String get homeBoarding_errorLoadingSitters =>
      'Something went wrong loading sitters. Please try again.';

  @override
  String get homeBoarding_errorLoadingSitter =>
      'Something went wrong loading this sitter. Please try again.';

  @override
  String get search_noResults => 'No results found.';

  @override
  String get search_startTyping => 'Start typing to search.';

  @override
  String get search_recentSearches => 'Recent Searches';

  @override
  String get search_clearAll => 'Clear all';

  @override
  String get search_error =>
      'Something went wrong searching. Please try again.';

  @override
  String get booking_detailsTitle => 'Booking Details';

  @override
  String get booking_selectRoom => 'Select at least one room.';

  @override
  String get booking_chooseDates => 'Choose your stay dates.';

  @override
  String get booking_chooseTimes => 'Choose drop-off and pick-up times.';

  @override
  String get booking_chooseDatesTitle => 'Choose dates';

  @override
  String get booking_dropOffTime => 'Drop off time';

  @override
  String get booking_pickUpTime => 'Pick up time';

  @override
  String get booking_numberOfPets => 'Number of pets';

  @override
  String get booking_servicesLabel => 'Services:';

  @override
  String get booking_priceOnRequest => 'Price on request';

  @override
  String get booking_chooseADate => 'Choose a date';

  @override
  String get booking_dropOffPickUpLabel => 'Drop off time & Pick up time';

  @override
  String get booking_dropOff => 'Drop off';

  @override
  String get booking_pickUp => 'Pick up';

  @override
  String get booking_confirmPayTitle => 'Confirm and Pay';

  @override
  String get booking_yourOrder => 'Your Order';

  @override
  String get booking_roomType => 'Package / Room Type';

  @override
  String get booking_servicesSelected => 'Services Selected';

  @override
  String get booking_numberOfPetsOrder => 'Number of Pets';

  @override
  String get booking_stayDuration => 'Stay Duration / Booking Date';

  @override
  String get booking_nextDaySuffix => ' (Next day)';

  @override
  String get booking_paymentMethod => 'Payment Method';

  @override
  String get booking_paymentSuccessTitle => 'Payment Successful';

  @override
  String get booking_seeDetails => 'See Details';

  @override
  String get booking_receiptTitle => 'Receipt';

  @override
  String get booking_receiptError =>
      'Something went wrong generating the receipt. Please try again.';

  @override
  String get booking_status => 'Status';

  @override
  String get booking_priceTitle => 'Price';

  @override
  String get booking_priceDetailsTitle => 'Price Details';

  @override
  String get booking_downloadPdf => 'Download PDF';

  @override
  String get booking_roomPrice => 'Room Price';

  @override
  String get booking_addonServices => 'Add-on Services';

  @override
  String get booking_totalBeforeFees => 'Total Before Fees';

  @override
  String get booking_appServiceFee => 'App Service Fee';

  @override
  String get booking_totalPrice => 'Total Price';

  @override
  String get booking_errorCreating =>
      'Something went wrong creating your booking. Please try again.';

  @override
  String get booking_errorAvailability =>
      'Something went wrong checking room availability. Please try again.';

  @override
  String booking_priceSar(String price) {
    return 'SAR $price';
  }

  @override
  String booking_amountSar(String amount) {
    return '$amount SAR';
  }

  @override
  String booking_dropOffTimeValue(String time) {
    return 'Drop-off: $time';
  }

  @override
  String booking_pickUpTimeValue(String time) {
    return 'Pick-up: $time';
  }

  @override
  String booking_nightsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count nights',
      one: '1 night',
    );
    return '$_temp0';
  }

  @override
  String booking_petsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Pets',
      one: '1 Pet',
    );
    return '$_temp0';
  }

  @override
  String booking_roomsLeft(int count, String roomName) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Only $count $roomName left for these dates.',
      one: 'Only 1 $roomName left for these dates.',
    );
    return '$_temp0';
  }

  @override
  String get paymentMethod_applePay => 'Apple Pay';

  @override
  String get paymentMethod_visa => 'Visa';

  @override
  String get paymentMethod_mastercard => 'Mastercard';

  @override
  String get applePay_payWordmark => 'Pay';

  @override
  String get applePay_cardName => 'Apple Card •••• 1234';

  @override
  String get applePay_confirmSideButton => 'Confirm with Side Button';

  @override
  String get adoption_screenTitle => 'Adoption';

  @override
  String get guest_title => 'Enjoy the Full Experience!';

  @override
  String get guest_body => 'Sign in to add your pets and access all features.';

  @override
  String get guest_cta => 'Get Started Now';

  @override
  String get pickers_chooseMonth => 'Choose month';

  @override
  String get pickers_backToCalendar => 'Back to calendar';

  @override
  String get pickers_selectDateRange => 'Select a date range';

  @override
  String get pickers_selectPetType => 'Select pet type';

  @override
  String get pickers_otherCommonPets => 'Other common pets';

  @override
  String get language_english => 'English';

  @override
  String get language_arabic => 'العربية';
}
