import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @common_retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get common_retry;

  /// No description provided for @common_cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get common_cancel;

  /// No description provided for @common_save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get common_save;

  /// No description provided for @common_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get common_next;

  /// No description provided for @common_goBack.
  ///
  /// In en, this message translates to:
  /// **'Go back'**
  String get common_goBack;

  /// No description provided for @common_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get common_continue;

  /// No description provided for @common_done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get common_done;

  /// No description provided for @common_confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get common_confirm;

  /// No description provided for @common_apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get common_apply;

  /// No description provided for @common_reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get common_reset;

  /// No description provided for @common_comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get common_comingSoon;

  /// No description provided for @common_seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get common_seeAll;

  /// No description provided for @common_yourPets.
  ///
  /// In en, this message translates to:
  /// **'Your Pets'**
  String get common_yourPets;

  /// No description provided for @common_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get common_email;

  /// No description provided for @common_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get common_password;

  /// No description provided for @common_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get common_name;

  /// No description provided for @common_firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get common_firstName;

  /// No description provided for @common_lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get common_lastName;

  /// No description provided for @common_phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get common_phoneNumber;

  /// No description provided for @common_nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get common_nameRequired;

  /// No description provided for @common_invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get common_invalidEmail;

  /// No description provided for @common_gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get common_gender;

  /// No description provided for @common_age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get common_age;

  /// No description provided for @common_breed.
  ///
  /// In en, this message translates to:
  /// **'Breed'**
  String get common_breed;

  /// No description provided for @common_genderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get common_genderMale;

  /// No description provided for @common_genderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get common_genderFemale;

  /// No description provided for @common_userFallback.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get common_userFallback;

  /// No description provided for @common_chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose Date'**
  String get common_chooseDate;

  /// No description provided for @common_chooseDateTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose date'**
  String get common_chooseDateTitle;

  /// No description provided for @common_chooseDatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose dates'**
  String get common_chooseDatesTitle;

  /// No description provided for @common_setTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'Set time'**
  String get common_setTimeTitle;

  /// No description provided for @common_chooseDateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Choose date of birth'**
  String get common_chooseDateOfBirth;

  /// No description provided for @common_couldNotPickImage.
  ///
  /// In en, this message translates to:
  /// **'Could not pick image'**
  String get common_couldNotPickImage;

  /// No description provided for @common_chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from gallery'**
  String get common_chooseFromGallery;

  /// No description provided for @common_takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get common_takePhoto;

  /// No description provided for @common_removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove photo'**
  String get common_removePhoto;

  /// No description provided for @common_searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get common_searchHint;

  /// No description provided for @common_date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get common_date;

  /// No description provided for @common_reviewsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{(1 review)} other{({count} reviews)}}'**
  String common_reviewsCount(int count);

  /// No description provided for @common_yearsExpShort.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 yr exp.} other{{count} yrs exp.}}'**
  String common_yearsExpShort(int count);

  /// No description provided for @common_pricePerNightSar.
  ///
  /// In en, this message translates to:
  /// **'SAR {price} / night'**
  String common_pricePerNightSar(String price);

  /// No description provided for @common_weightKg.
  ///
  /// In en, this message translates to:
  /// **'{value} kg'**
  String common_weightKg(String value);

  /// No description provided for @common_locationDistance.
  ///
  /// In en, this message translates to:
  /// **'{location} — {distance} km'**
  String common_locationDistance(String location, String distance);

  /// No description provided for @pet_ageMonths.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 month} other{{count} months}}'**
  String pet_ageMonths(int count);

  /// No description provided for @pet_ageYears.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 Year} other{{count} Years}}'**
  String pet_ageYears(int count);

  /// No description provided for @species_cat.
  ///
  /// In en, this message translates to:
  /// **'Cat'**
  String get species_cat;

  /// No description provided for @species_dog.
  ///
  /// In en, this message translates to:
  /// **'Dog'**
  String get species_dog;

  /// No description provided for @species_bird.
  ///
  /// In en, this message translates to:
  /// **'Bird'**
  String get species_bird;

  /// No description provided for @species_falcon.
  ///
  /// In en, this message translates to:
  /// **'Falcon'**
  String get species_falcon;

  /// No description provided for @species_rabbit.
  ///
  /// In en, this message translates to:
  /// **'Rabbit'**
  String get species_rabbit;

  /// No description provided for @species_fish.
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get species_fish;

  /// No description provided for @species_turtle.
  ///
  /// In en, this message translates to:
  /// **'Turtle'**
  String get species_turtle;

  /// No description provided for @species_hamster.
  ///
  /// In en, this message translates to:
  /// **'Hamster'**
  String get species_hamster;

  /// No description provided for @species_pigeon.
  ///
  /// In en, this message translates to:
  /// **'Pigeon'**
  String get species_pigeon;

  /// No description provided for @species_horse.
  ///
  /// In en, this message translates to:
  /// **'Horse'**
  String get species_horse;

  /// No description provided for @species_other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get species_other;

  /// No description provided for @welcome_title.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Rifq'**
  String get welcome_title;

  /// No description provided for @welcome_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Your trusted space for pet care and services.'**
  String get welcome_subtitle;

  /// No description provided for @welcome_signInPrompt.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue caring with ease.'**
  String get welcome_signInPrompt;

  /// No description provided for @welcome_signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get welcome_signIn;

  /// No description provided for @welcome_continueGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as Guest'**
  String get welcome_continueGuest;

  /// No description provided for @choosePath_subtitle.
  ///
  /// In en, this message translates to:
  /// **'making pet care simple for everyone'**
  String get choosePath_subtitle;

  /// No description provided for @choosePath_prompt.
  ///
  /// In en, this message translates to:
  /// **'Choose your path to start:'**
  String get choosePath_prompt;

  /// No description provided for @choosePath_petOwner.
  ///
  /// In en, this message translates to:
  /// **'I own a pet'**
  String get choosePath_petOwner;

  /// No description provided for @choosePath_serviceProvider.
  ///
  /// In en, this message translates to:
  /// **'I provide care services'**
  String get choosePath_serviceProvider;

  /// No description provided for @onboarding_title1.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Rifq!'**
  String get onboarding_title1;

  /// No description provided for @onboarding_title2.
  ///
  /// In en, this message translates to:
  /// **'Track Your Pet’s \n Health Easily'**
  String get onboarding_title2;

  /// No description provided for @onboarding_title3.
  ///
  /// In en, this message translates to:
  /// **'Smart Care, Anytime'**
  String get onboarding_title3;

  /// No description provided for @onboarding_subtitle1.
  ///
  /// In en, this message translates to:
  /// **'Your all-in-one app for caring, tracking,\n and supporting every moment of your \n pet’s life.'**
  String get onboarding_subtitle1;

  /// No description provided for @onboarding_subtitle2.
  ///
  /// In en, this message translates to:
  /// **'Keep all medical records, vaccinations,\n and check-ups organized in one smart \n health card.'**
  String get onboarding_subtitle2;

  /// No description provided for @onboarding_subtitle3.
  ///
  /// In en, this message translates to:
  /// **'Use AI to check symptoms,\n find nearby clinics, home services, \n hotels, and everything your pet needs.'**
  String get onboarding_subtitle3;

  /// No description provided for @onboarding_getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get started'**
  String get onboarding_getStarted;

  /// No description provided for @onboarding_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboarding_skip;

  /// No description provided for @auth_loginTab.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get auth_loginTab;

  /// No description provided for @auth_signupTab.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get auth_signupTab;

  /// No description provided for @auth_loginPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and password.'**
  String get auth_loginPrompt;

  /// No description provided for @auth_signupPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please fill in your details to continue.'**
  String get auth_signupPrompt;

  /// No description provided for @auth_emailHintError.
  ///
  /// In en, this message translates to:
  /// **'(e.g., username@example.com).'**
  String get auth_emailHintError;

  /// No description provided for @auth_passwordError.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password. Please try again.'**
  String get auth_passwordError;

  /// No description provided for @auth_passwordRule.
  ///
  /// In en, this message translates to:
  /// **'Includes at least one number or symbol (e.g., @, #, \$, !).'**
  String get auth_passwordRule;

  /// No description provided for @auth_forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get auth_forgotPassword;

  /// No description provided for @auth_loginButton.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get auth_loginButton;

  /// No description provided for @auth_signupButton.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get auth_signupButton;

  /// No description provided for @auth_verifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get auth_verifyButton;

  /// No description provided for @auth_agreePrefix.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our '**
  String get auth_agreePrefix;

  /// No description provided for @auth_termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions '**
  String get auth_termsAndConditions;

  /// No description provided for @auth_agreeAnd.
  ///
  /// In en, this message translates to:
  /// **'and '**
  String get auth_agreeAnd;

  /// No description provided for @auth_privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get auth_privacyPolicy;

  /// No description provided for @auth_resetPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get auth_resetPasswordTitle;

  /// No description provided for @auth_resetPasswordPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please enter your new password to proceed.'**
  String get auth_resetPasswordPrompt;

  /// No description provided for @auth_sendEmailPrompt.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to verify and reset your password.'**
  String get auth_sendEmailPrompt;

  /// No description provided for @otp_confirmNewEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Email'**
  String get otp_confirmNewEmailTitle;

  /// No description provided for @otp_emailVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Email Verification'**
  String get otp_emailVerificationTitle;

  /// No description provided for @otp_emailUpdated.
  ///
  /// In en, this message translates to:
  /// **'Email updated successfully'**
  String get otp_emailUpdated;

  /// No description provided for @otp_sentAgain.
  ///
  /// In en, this message translates to:
  /// **'OTP sent again'**
  String get otp_sentAgain;

  /// No description provided for @otp_sentNewEmailBody.
  ///
  /// In en, this message translates to:
  /// **'We have sent an OTP to your new email address'**
  String get otp_sentNewEmailBody;

  /// No description provided for @otp_sentEmailBody.
  ///
  /// In en, this message translates to:
  /// **'We have sent an OTP to your email address'**
  String get otp_sentEmailBody;

  /// No description provided for @otp_enterBelow.
  ///
  /// In en, this message translates to:
  /// **'Please enter the OTP below'**
  String get otp_enterBelow;

  /// No description provided for @otp_resendCodeIn.
  ///
  /// In en, this message translates to:
  /// **'Resend code in {time}'**
  String otp_resendCodeIn(String time);

  /// No description provided for @otp_sending.
  ///
  /// In en, this message translates to:
  /// **'Sending...'**
  String get otp_sending;

  /// No description provided for @otp_resend.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get otp_resend;

  /// No description provided for @nav_askAi.
  ///
  /// In en, this message translates to:
  /// **'Ask AI'**
  String get nav_askAi;

  /// No description provided for @nav_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get nav_home;

  /// No description provided for @nav_health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get nav_health;

  /// No description provided for @nav_hotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get nav_hotel;

  /// No description provided for @nav_adoption.
  ///
  /// In en, this message translates to:
  /// **'Adoption'**
  String get nav_adoption;

  /// No description provided for @home_quickService.
  ///
  /// In en, this message translates to:
  /// **'Quick Service'**
  String get home_quickService;

  /// No description provided for @home_clinicVisit.
  ///
  /// In en, this message translates to:
  /// **'Clinic Visit'**
  String get home_clinicVisit;

  /// No description provided for @home_petHotel.
  ///
  /// In en, this message translates to:
  /// **'Pet Hotel'**
  String get home_petHotel;

  /// No description provided for @home_adopt.
  ///
  /// In en, this message translates to:
  /// **'Adopt'**
  String get home_adopt;

  /// No description provided for @home_recommendations.
  ///
  /// In en, this message translates to:
  /// **'Recommendations'**
  String get home_recommendations;

  /// No description provided for @home_welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get home_welcome;

  /// No description provided for @home_helloPrefix.
  ///
  /// In en, this message translates to:
  /// **'Hello, '**
  String get home_helloPrefix;

  /// No description provided for @home_addPet.
  ///
  /// In en, this message translates to:
  /// **'Add Pet'**
  String get home_addPet;

  /// No description provided for @account_securityPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Security & Privacy'**
  String get account_securityPrivacy;

  /// No description provided for @account_language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get account_language;

  /// No description provided for @account_logout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get account_logout;

  /// No description provided for @account_logoutConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to log out?'**
  String get account_logoutConfirmMessage;

  /// No description provided for @account_noPetsYet.
  ///
  /// In en, this message translates to:
  /// **'No pets yet'**
  String get account_noPetsYet;

  /// No description provided for @account_listedForAdoption.
  ///
  /// In en, this message translates to:
  /// **'Listed for Adoption'**
  String get account_listedForAdoption;

  /// No description provided for @account_phoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get account_phoneRequired;

  /// No description provided for @account_phoneInvalid9.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid 9-digit phone number'**
  String get account_phoneInvalid9;

  /// No description provided for @account_selectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select country'**
  String get account_selectCountry;

  /// No description provided for @account_searchCountry.
  ///
  /// In en, this message translates to:
  /// **'Search by name or code'**
  String get account_searchCountry;

  /// No description provided for @account_noCountriesFound.
  ///
  /// In en, this message translates to:
  /// **'No countries found'**
  String get account_noCountriesFound;

  /// No description provided for @editProfile_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile_title;

  /// No description provided for @editProfile_otpSentNewEmail.
  ///
  /// In en, this message translates to:
  /// **'We sent an OTP to your new email'**
  String get editProfile_otpSentNewEmail;

  /// No description provided for @editProfile_profileUpdated.
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get editProfile_profileUpdated;

  /// No description provided for @editProfile_signInToEdit.
  ///
  /// In en, this message translates to:
  /// **'Sign in to edit profile'**
  String get editProfile_signInToEdit;

  /// No description provided for @editProfile_firstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get editProfile_firstNameRequired;

  /// No description provided for @editProfile_emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get editProfile_emailRequired;

  /// No description provided for @petProfile_title.
  ///
  /// In en, this message translates to:
  /// **'Pet Profile'**
  String get petProfile_title;

  /// No description provided for @petProfile_tabHealthRecord.
  ///
  /// In en, this message translates to:
  /// **'Health Record'**
  String get petProfile_tabHealthRecord;

  /// No description provided for @petProfile_tabAppointment.
  ///
  /// In en, this message translates to:
  /// **'Appointment'**
  String get petProfile_tabAppointment;

  /// No description provided for @petProfile_noAppointments.
  ///
  /// In en, this message translates to:
  /// **'No Appointments Yet'**
  String get petProfile_noAppointments;

  /// No description provided for @addPet_title.
  ///
  /// In en, this message translates to:
  /// **'Add Your Pet'**
  String get addPet_title;

  /// No description provided for @addPet_success.
  ///
  /// In en, this message translates to:
  /// **'Pet added successfully'**
  String get addPet_success;

  /// No description provided for @addPet_completeAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please complete all fields'**
  String get addPet_completeAllFields;

  /// No description provided for @addPet_profileNotFound.
  ///
  /// In en, this message translates to:
  /// **'User profile not found'**
  String get addPet_profileNotFound;

  /// No description provided for @addPet_uploadPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload your pet\'s photo'**
  String get addPet_uploadPhoto;

  /// No description provided for @addPet_nameQuestion.
  ///
  /// In en, this message translates to:
  /// **'What\'s your pet\'s name?'**
  String get addPet_nameQuestion;

  /// No description provided for @addPet_nameHint.
  ///
  /// In en, this message translates to:
  /// **'Mila'**
  String get addPet_nameHint;

  /// No description provided for @addPet_genderQuestion.
  ///
  /// In en, this message translates to:
  /// **'What\'s your pet\'s gender?'**
  String get addPet_genderQuestion;

  /// No description provided for @addPet_ageQuestion.
  ///
  /// In en, this message translates to:
  /// **'What\'s your pet\'s age?'**
  String get addPet_ageQuestion;

  /// No description provided for @addPet_typeQuestion.
  ///
  /// In en, this message translates to:
  /// **'What type of pet do you have?'**
  String get addPet_typeQuestion;

  /// No description provided for @addPet_breedQuestion.
  ///
  /// In en, this message translates to:
  /// **'What\'s your pet\'s breed?'**
  String get addPet_breedQuestion;

  /// No description provided for @addPet_breedHint.
  ///
  /// In en, this message translates to:
  /// **'Husky'**
  String get addPet_breedHint;

  /// No description provided for @addPet_ageValue.
  ///
  /// In en, this message translates to:
  /// **'Age: {age}'**
  String addPet_ageValue(String age);

  /// No description provided for @editPet_title.
  ///
  /// In en, this message translates to:
  /// **'Edit Pet'**
  String get editPet_title;

  /// No description provided for @editPet_updated.
  ///
  /// In en, this message translates to:
  /// **'Pet updated'**
  String get editPet_updated;

  /// No description provided for @editPet_nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Pet\'s Name'**
  String get editPet_nameLabel;

  /// No description provided for @editPet_breedLabel.
  ///
  /// In en, this message translates to:
  /// **'Pet\'s breed'**
  String get editPet_breedLabel;

  /// No description provided for @editPet_breedRequired.
  ///
  /// In en, this message translates to:
  /// **'Breed is required'**
  String get editPet_breedRequired;

  /// No description provided for @editPet_weightLabel.
  ///
  /// In en, this message translates to:
  /// **'Pet\'s weight'**
  String get editPet_weightLabel;

  /// No description provided for @editPet_ageLabel.
  ///
  /// In en, this message translates to:
  /// **'Pet\'s age'**
  String get editPet_ageLabel;

  /// No description provided for @editPet_ageRequired.
  ///
  /// In en, this message translates to:
  /// **'Pet age is required'**
  String get editPet_ageRequired;

  /// No description provided for @editPet_invalidWeight.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid weight'**
  String get editPet_invalidWeight;

  /// No description provided for @healthRecord_chooseVisitDate.
  ///
  /// In en, this message translates to:
  /// **'Choose date of visit'**
  String get healthRecord_chooseVisitDate;

  /// No description provided for @healthRecord_visitDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please choose a visit date'**
  String get healthRecord_visitDateRequired;

  /// No description provided for @healthRecord_saved.
  ///
  /// In en, this message translates to:
  /// **'Health record saved'**
  String get healthRecord_saved;

  /// No description provided for @healthRecord_addTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Health Record'**
  String get healthRecord_addTitle;

  /// No description provided for @healthRecord_fieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get healthRecord_fieldTitle;

  /// No description provided for @healthRecord_titleRequired.
  ///
  /// In en, this message translates to:
  /// **'Title is required'**
  String get healthRecord_titleRequired;

  /// No description provided for @healthRecord_fieldType.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get healthRecord_fieldType;

  /// No description provided for @healthRecord_typeRequired.
  ///
  /// In en, this message translates to:
  /// **'Type is required'**
  String get healthRecord_typeRequired;

  /// No description provided for @healthRecord_fieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get healthRecord_fieldDescription;

  /// No description provided for @healthRecord_fieldClinic.
  ///
  /// In en, this message translates to:
  /// **'Clinic Name'**
  String get healthRecord_fieldClinic;

  /// No description provided for @healthRecord_saveRecord.
  ///
  /// In en, this message translates to:
  /// **'Save Record'**
  String get healthRecord_saveRecord;

  /// No description provided for @healthRecord_dateOfVisit.
  ///
  /// In en, this message translates to:
  /// **'Date of Visit'**
  String get healthRecord_dateOfVisit;

  /// No description provided for @healthRecord_empty.
  ///
  /// In en, this message translates to:
  /// **'No Health Record Yet'**
  String get healthRecord_empty;

  /// No description provided for @healthRecord_addNew.
  ///
  /// In en, this message translates to:
  /// **'Add new health record'**
  String get healthRecord_addNew;

  /// No description provided for @hotel_screenTitle.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get hotel_screenTitle;

  /// No description provided for @hotel_bookNow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get hotel_bookNow;

  /// No description provided for @hotel_tabHotels.
  ///
  /// In en, this message translates to:
  /// **'Hotels'**
  String get hotel_tabHotels;

  /// No description provided for @hotel_tabHomeBoarding.
  ///
  /// In en, this message translates to:
  /// **'Home Boarding'**
  String get hotel_tabHomeBoarding;

  /// No description provided for @hotel_tabRooms.
  ///
  /// In en, this message translates to:
  /// **'Rooms'**
  String get hotel_tabRooms;

  /// No description provided for @hotel_tabInfo.
  ///
  /// In en, this message translates to:
  /// **'Hotel Info'**
  String get hotel_tabInfo;

  /// No description provided for @hotel_noRooms.
  ///
  /// In en, this message translates to:
  /// **'No rooms listed for this hotel yet.'**
  String get hotel_noRooms;

  /// No description provided for @hotel_otherServices.
  ///
  /// In en, this message translates to:
  /// **'Other Services'**
  String get hotel_otherServices;

  /// No description provided for @hotel_aboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About the Hotel'**
  String get hotel_aboutTitle;

  /// No description provided for @hotel_noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description available yet.'**
  String get hotel_noDescription;

  /// No description provided for @hotel_facilities.
  ///
  /// In en, this message translates to:
  /// **'Facilities'**
  String get hotel_facilities;

  /// No description provided for @hotel_rulesTitle.
  ///
  /// In en, this message translates to:
  /// **'Rules & Requirements'**
  String get hotel_rulesTitle;

  /// No description provided for @hotel_location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get hotel_location;

  /// No description provided for @hotel_servicesLabel.
  ///
  /// In en, this message translates to:
  /// **'Services : '**
  String get hotel_servicesLabel;

  /// No description provided for @hotel_includesLabel.
  ///
  /// In en, this message translates to:
  /// **'Includes :'**
  String get hotel_includesLabel;

  /// No description provided for @hotel_priceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Price unavailable'**
  String get hotel_priceUnavailable;

  /// No description provided for @hotel_sortFilterTitle.
  ///
  /// In en, this message translates to:
  /// **'Sort & Filter'**
  String get hotel_sortFilterTitle;

  /// No description provided for @hotel_emptyHotels.
  ///
  /// In en, this message translates to:
  /// **'No hotels available right now — check back soon.'**
  String get hotel_emptyHotels;

  /// No description provided for @hotel_emptySitters.
  ///
  /// In en, this message translates to:
  /// **'No sitters available right now — check back soon.'**
  String get hotel_emptySitters;

  /// No description provided for @hotel_errorLoadingHotels.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong loading hotels. Please try again.'**
  String get hotel_errorLoadingHotels;

  /// No description provided for @hotel_startingPrice.
  ///
  /// In en, this message translates to:
  /// **'Start from {price} SAR/night'**
  String hotel_startingPrice(String price);

  /// No description provided for @hotel_locationDistance.
  ///
  /// In en, this message translates to:
  /// **'{location} – {distance} km'**
  String hotel_locationDistance(String location, String distance);

  /// No description provided for @hotel_servicePrice.
  ///
  /// In en, this message translates to:
  /// **'{name} : SAR {price}'**
  String hotel_servicePrice(String name, String price);

  /// No description provided for @hotel_roomsTotal.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 room total} other{{count} rooms total}}'**
  String hotel_roomsTotal(int count);

  /// No description provided for @hotel_available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get hotel_available;

  /// No description provided for @hotel_availabilityLabel.
  ///
  /// In en, this message translates to:
  /// **'Availability : '**
  String get hotel_availabilityLabel;

  /// No description provided for @hotel_roomsAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 room available} other{{count} rooms available}}'**
  String hotel_roomsAvailable(int count);

  /// No description provided for @sortOption_recommended.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get sortOption_recommended;

  /// No description provided for @sortOption_nearest.
  ///
  /// In en, this message translates to:
  /// **'Nearest'**
  String get sortOption_nearest;

  /// No description provided for @sortOption_topRated.
  ///
  /// In en, this message translates to:
  /// **'Top Rated'**
  String get sortOption_topRated;

  /// No description provided for @sortOption_lowestPrice.
  ///
  /// In en, this message translates to:
  /// **'Lowest Price'**
  String get sortOption_lowestPrice;

  /// No description provided for @sortOption_mostExperienced.
  ///
  /// In en, this message translates to:
  /// **'Most Experienced'**
  String get sortOption_mostExperienced;

  /// No description provided for @homeBoarding_contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get homeBoarding_contact;

  /// No description provided for @homeBoarding_about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get homeBoarding_about;

  /// No description provided for @homeBoarding_skills.
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get homeBoarding_skills;

  /// No description provided for @homeBoarding_requestPending.
  ///
  /// In en, this message translates to:
  /// **'Request Pending'**
  String get homeBoarding_requestPending;

  /// No description provided for @homeBoarding_sendRequest.
  ///
  /// In en, this message translates to:
  /// **'Send Request'**
  String get homeBoarding_sendRequest;

  /// No description provided for @homeBoarding_requestSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Request Sent!'**
  String get homeBoarding_requestSentTitle;

  /// No description provided for @homeBoarding_requestSentBody.
  ///
  /// In en, this message translates to:
  /// **'Your home boarding request has been sent to the host.'**
  String get homeBoarding_requestSentBody;

  /// No description provided for @homeBoarding_backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get homeBoarding_backToHome;

  /// No description provided for @homeBoarding_errorChecking.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong checking your requests. Please try again.'**
  String get homeBoarding_errorChecking;

  /// No description provided for @homeBoarding_errorSending.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong sending your request. Please try again.'**
  String get homeBoarding_errorSending;

  /// No description provided for @homeBoarding_errorLoadingSitters.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong loading sitters. Please try again.'**
  String get homeBoarding_errorLoadingSitters;

  /// No description provided for @homeBoarding_errorLoadingSitter.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong loading this sitter. Please try again.'**
  String get homeBoarding_errorLoadingSitter;

  /// No description provided for @search_noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found.'**
  String get search_noResults;

  /// No description provided for @search_startTyping.
  ///
  /// In en, this message translates to:
  /// **'Start typing to search.'**
  String get search_startTyping;

  /// No description provided for @search_recentSearches.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get search_recentSearches;

  /// No description provided for @search_clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get search_clearAll;

  /// No description provided for @search_error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong searching. Please try again.'**
  String get search_error;

  /// No description provided for @booking_detailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Booking Details'**
  String get booking_detailsTitle;

  /// No description provided for @booking_selectRoom.
  ///
  /// In en, this message translates to:
  /// **'Select at least one room.'**
  String get booking_selectRoom;

  /// No description provided for @booking_chooseDates.
  ///
  /// In en, this message translates to:
  /// **'Choose your stay dates.'**
  String get booking_chooseDates;

  /// No description provided for @booking_chooseTimes.
  ///
  /// In en, this message translates to:
  /// **'Choose drop-off and pick-up times.'**
  String get booking_chooseTimes;

  /// No description provided for @booking_chooseDatesTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose dates'**
  String get booking_chooseDatesTitle;

  /// No description provided for @booking_dropOffTime.
  ///
  /// In en, this message translates to:
  /// **'Drop off time'**
  String get booking_dropOffTime;

  /// No description provided for @booking_pickUpTime.
  ///
  /// In en, this message translates to:
  /// **'Pick up time'**
  String get booking_pickUpTime;

  /// No description provided for @booking_numberOfPets.
  ///
  /// In en, this message translates to:
  /// **'Number of pets'**
  String get booking_numberOfPets;

  /// No description provided for @booking_servicesLabel.
  ///
  /// In en, this message translates to:
  /// **'Services:'**
  String get booking_servicesLabel;

  /// No description provided for @booking_priceOnRequest.
  ///
  /// In en, this message translates to:
  /// **'Price on request'**
  String get booking_priceOnRequest;

  /// No description provided for @booking_chooseADate.
  ///
  /// In en, this message translates to:
  /// **'Choose a date'**
  String get booking_chooseADate;

  /// No description provided for @booking_dropOffPickUpLabel.
  ///
  /// In en, this message translates to:
  /// **'Drop off time & Pick up time'**
  String get booking_dropOffPickUpLabel;

  /// No description provided for @booking_dropOff.
  ///
  /// In en, this message translates to:
  /// **'Drop off'**
  String get booking_dropOff;

  /// No description provided for @booking_pickUp.
  ///
  /// In en, this message translates to:
  /// **'Pick up'**
  String get booking_pickUp;

  /// No description provided for @booking_confirmPayTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm and Pay'**
  String get booking_confirmPayTitle;

  /// No description provided for @booking_yourOrder.
  ///
  /// In en, this message translates to:
  /// **'Your Order'**
  String get booking_yourOrder;

  /// No description provided for @booking_roomType.
  ///
  /// In en, this message translates to:
  /// **'Package / Room Type'**
  String get booking_roomType;

  /// No description provided for @booking_servicesSelected.
  ///
  /// In en, this message translates to:
  /// **'Services Selected'**
  String get booking_servicesSelected;

  /// No description provided for @booking_numberOfPetsOrder.
  ///
  /// In en, this message translates to:
  /// **'Number of Pets'**
  String get booking_numberOfPetsOrder;

  /// No description provided for @booking_stayDuration.
  ///
  /// In en, this message translates to:
  /// **'Stay Duration / Booking Date'**
  String get booking_stayDuration;

  /// No description provided for @booking_nextDaySuffix.
  ///
  /// In en, this message translates to:
  /// **' (Next day)'**
  String get booking_nextDaySuffix;

  /// No description provided for @booking_paymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get booking_paymentMethod;

  /// No description provided for @booking_paymentSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Successful'**
  String get booking_paymentSuccessTitle;

  /// No description provided for @booking_seeDetails.
  ///
  /// In en, this message translates to:
  /// **'See Details'**
  String get booking_seeDetails;

  /// No description provided for @booking_receiptTitle.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get booking_receiptTitle;

  /// No description provided for @booking_receiptError.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong generating the receipt. Please try again.'**
  String get booking_receiptError;

  /// No description provided for @booking_status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get booking_status;

  /// No description provided for @booking_priceTitle.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get booking_priceTitle;

  /// No description provided for @booking_priceDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Price Details'**
  String get booking_priceDetailsTitle;

  /// No description provided for @booking_downloadPdf.
  ///
  /// In en, this message translates to:
  /// **'Download PDF'**
  String get booking_downloadPdf;

  /// No description provided for @booking_downloadReceipt.
  ///
  /// In en, this message translates to:
  /// **'Download Receipt'**
  String get booking_downloadReceipt;

  /// No description provided for @booking_roomPrice.
  ///
  /// In en, this message translates to:
  /// **'Room Price'**
  String get booking_roomPrice;

  /// No description provided for @booking_addonServices.
  ///
  /// In en, this message translates to:
  /// **'Add-on Services'**
  String get booking_addonServices;

  /// No description provided for @booking_totalBeforeFees.
  ///
  /// In en, this message translates to:
  /// **'Total Before Fees'**
  String get booking_totalBeforeFees;

  /// No description provided for @booking_appServiceFee.
  ///
  /// In en, this message translates to:
  /// **'App Service Fee'**
  String get booking_appServiceFee;

  /// No description provided for @booking_totalPrice.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get booking_totalPrice;

  /// No description provided for @booking_errorCreating.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong creating your booking. Please try again.'**
  String get booking_errorCreating;

  /// No description provided for @booking_errorAvailability.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong checking room availability. Please try again.'**
  String get booking_errorAvailability;

  /// No description provided for @booking_priceSar.
  ///
  /// In en, this message translates to:
  /// **'SAR {price}'**
  String booking_priceSar(String price);

  /// No description provided for @booking_amountSar.
  ///
  /// In en, this message translates to:
  /// **'{amount} SAR'**
  String booking_amountSar(String amount);

  /// No description provided for @booking_dropOffTimeValue.
  ///
  /// In en, this message translates to:
  /// **'Drop-off: {time}'**
  String booking_dropOffTimeValue(String time);

  /// No description provided for @booking_pickUpTimeValue.
  ///
  /// In en, this message translates to:
  /// **'Pick-up: {time}'**
  String booking_pickUpTimeValue(String time);

  /// No description provided for @booking_nightsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 night} other{{count} nights}}'**
  String booking_nightsCount(int count);

  /// No description provided for @booking_petsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 Pet} other{{count} Pets}}'**
  String booking_petsCount(int count);

  /// No description provided for @booking_roomsLeft.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{Only 1 {roomName} left for these dates.} other{Only {count} {roomName} left for these dates.}}'**
  String booking_roomsLeft(int count, String roomName);

  /// No description provided for @booking_roomsExceedPets.
  ///
  /// In en, this message translates to:
  /// **'You can\'t reserve more rooms than the number of pets.'**
  String get booking_roomsExceedPets;

  /// No description provided for @booking_petsExceedOwned.
  ///
  /// In en, this message translates to:
  /// **'You can\'t select more pets than you have registered.'**
  String get booking_petsExceedOwned;

  /// No description provided for @paymentMethod_applePay.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay'**
  String get paymentMethod_applePay;

  /// No description provided for @paymentMethod_visa.
  ///
  /// In en, this message translates to:
  /// **'Visa'**
  String get paymentMethod_visa;

  /// No description provided for @paymentMethod_mastercard.
  ///
  /// In en, this message translates to:
  /// **'Mastercard'**
  String get paymentMethod_mastercard;

  /// No description provided for @applePay_payWordmark.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get applePay_payWordmark;

  /// No description provided for @applePay_cardName.
  ///
  /// In en, this message translates to:
  /// **'Apple Card •••• 1234'**
  String get applePay_cardName;

  /// No description provided for @applePay_confirmSideButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm with Side Button'**
  String get applePay_confirmSideButton;

  /// No description provided for @pet_ageLessThanOneMonth.
  ///
  /// In en, this message translates to:
  /// **'Less than 1 month'**
  String get pet_ageLessThanOneMonth;

  /// No description provided for @adoption_screenTitle.
  ///
  /// In en, this message translates to:
  /// **'Adoption'**
  String get adoption_screenTitle;

  /// No description provided for @adoption_tabForAdoption.
  ///
  /// In en, this message translates to:
  /// **'For Adoption'**
  String get adoption_tabForAdoption;

  /// No description provided for @adoption_tabMyPets.
  ///
  /// In en, this message translates to:
  /// **'My Pets'**
  String get adoption_tabMyPets;

  /// No description provided for @adoption_petCategories.
  ///
  /// In en, this message translates to:
  /// **'Pet Categories'**
  String get adoption_petCategories;

  /// No description provided for @adoption_moreCategories.
  ///
  /// In en, this message translates to:
  /// **'More categories'**
  String get adoption_moreCategories;

  /// No description provided for @adoption_chooseOption.
  ///
  /// In en, this message translates to:
  /// **'Choose an option'**
  String get adoption_chooseOption;

  /// No description provided for @adoption_chooseOptionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How would you like to list a pet for adoption?'**
  String get adoption_chooseOptionSubtitle;

  /// No description provided for @adoption_addNewPet.
  ///
  /// In en, this message translates to:
  /// **'Add new pet'**
  String get adoption_addNewPet;

  /// No description provided for @adoption_selectFromMyPets.
  ///
  /// In en, this message translates to:
  /// **'Select from my pets'**
  String get adoption_selectFromMyPets;

  /// No description provided for @adoption_emptyAvailable.
  ///
  /// In en, this message translates to:
  /// **'No pets available for adoption'**
  String get adoption_emptyAvailable;

  /// No description provided for @adoption_emptyMyListings.
  ///
  /// In en, this message translates to:
  /// **'You have no pets for adoption'**
  String get adoption_emptyMyListings;

  /// No description provided for @adoption_myListingsTitle.
  ///
  /// In en, this message translates to:
  /// **'My Adoption Listings'**
  String get adoption_myListingsTitle;

  /// No description provided for @adoption_removeListingTitle.
  ///
  /// In en, this message translates to:
  /// **'Remove listing'**
  String get adoption_removeListingTitle;

  /// No description provided for @adoption_removeListingMessage.
  ///
  /// In en, this message translates to:
  /// **'This will remove the pet from adoption. The pet will stay in your pets.'**
  String get adoption_removeListingMessage;

  /// No description provided for @adoption_deleteListing.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adoption_deleteListing;

  /// No description provided for @adoption_listingRemoved.
  ///
  /// In en, this message translates to:
  /// **'Adoption listing removed'**
  String get adoption_listingRemoved;

  /// No description provided for @adoption_whichPet.
  ///
  /// In en, this message translates to:
  /// **'Which pet?'**
  String get adoption_whichPet;

  /// No description provided for @adoption_choosePetToList.
  ///
  /// In en, this message translates to:
  /// **'Choose a pet to list for adoption'**
  String get adoption_choosePetToList;

  /// No description provided for @adoption_noPetsToSelect.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any pets yet.'**
  String get adoption_noPetsToSelect;

  /// No description provided for @adoption_defaultDescription.
  ///
  /// In en, this message translates to:
  /// **'Pet available for adoption'**
  String get adoption_defaultDescription;

  /// No description provided for @adoption_petAddedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Pet added to adoption successfully'**
  String get adoption_petAddedSuccess;

  /// No description provided for @adoption_locationAndPhoneRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter location and phone number'**
  String get adoption_locationAndPhoneRequired;

  /// No description provided for @adoption_locationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get adoption_locationLabel;

  /// No description provided for @adoption_locationHint.
  ///
  /// In en, this message translates to:
  /// **'Riyadh'**
  String get adoption_locationHint;

  /// No description provided for @adoption_petDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Pet Details'**
  String get adoption_petDetailsTitle;

  /// No description provided for @adoption_noDetails.
  ///
  /// In en, this message translates to:
  /// **'No pet details available'**
  String get adoption_noDetails;

  /// No description provided for @adoption_unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get adoption_unknown;

  /// No description provided for @adoption_notAvailable.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get adoption_notAvailable;

  /// No description provided for @adoption_weight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get adoption_weight;

  /// No description provided for @adoption_ownedBy.
  ///
  /// In en, this message translates to:
  /// **'Owned by:'**
  String get adoption_ownedBy;

  /// No description provided for @adoption_petOwnerFallback.
  ///
  /// In en, this message translates to:
  /// **'Pet Owner'**
  String get adoption_petOwnerFallback;

  /// No description provided for @adoption_noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description available.'**
  String get adoption_noDescription;

  /// No description provided for @adoption_requestPending.
  ///
  /// In en, this message translates to:
  /// **'Request pending'**
  String get adoption_requestPending;

  /// No description provided for @adoption_requestAgain.
  ///
  /// In en, this message translates to:
  /// **'Request again'**
  String get adoption_requestAgain;

  /// No description provided for @adoption_formTitle.
  ///
  /// In en, this message translates to:
  /// **'Adoption Form'**
  String get adoption_formTitle;

  /// No description provided for @adoption_city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get adoption_city;

  /// No description provided for @adoption_cityRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your city'**
  String get adoption_cityRequired;

  /// No description provided for @adoption_nameMissing.
  ///
  /// In en, this message translates to:
  /// **'Your profile name is missing'**
  String get adoption_nameMissing;

  /// No description provided for @adoption_experienceLabel.
  ///
  /// In en, this message translates to:
  /// **'Experience with pets'**
  String get adoption_experienceLabel;

  /// No description provided for @adoption_experienceRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your experience with pets'**
  String get adoption_experienceRequired;

  /// No description provided for @adoption_enterNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a number'**
  String get adoption_enterNumber;

  /// No description provided for @adoption_shortNote.
  ///
  /// In en, this message translates to:
  /// **'Short note'**
  String get adoption_shortNote;

  /// No description provided for @adoption_noteRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a short note'**
  String get adoption_noteRequired;

  /// No description provided for @adoption_loginFirst.
  ///
  /// In en, this message translates to:
  /// **'Please login first'**
  String get adoption_loginFirst;

  /// No description provided for @adoption_requestSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Request sent successfully'**
  String get adoption_requestSentTitle;

  /// No description provided for @adoption_requestSentBody.
  ///
  /// In en, this message translates to:
  /// **'Your adoption request has been sent to the owner.\nYou will be notified once they respond.'**
  String get adoption_requestSentBody;

  /// No description provided for @adoption_backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get adoption_backToHome;

  /// No description provided for @adoption_noRequests.
  ///
  /// In en, this message translates to:
  /// **'No adoption requests yet'**
  String get adoption_noRequests;

  /// No description provided for @adoption_requestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Adoption requests – {petName}'**
  String adoption_requestsTitle(String petName);

  /// No description provided for @adoption_requestAccepted.
  ///
  /// In en, this message translates to:
  /// **'Request accepted. The pet was transferred to the adopter.'**
  String get adoption_requestAccepted;

  /// No description provided for @adoption_badgeNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get adoption_badgeNew;

  /// No description provided for @adoption_statusAccepted.
  ///
  /// In en, this message translates to:
  /// **'Accepted'**
  String get adoption_statusAccepted;

  /// No description provided for @adoption_statusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get adoption_statusRejected;

  /// No description provided for @adoption_viewRequest.
  ///
  /// In en, this message translates to:
  /// **'View Request'**
  String get adoption_viewRequest;

  /// No description provided for @adoption_requestsCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 Request} other{{count} Requests}}'**
  String adoption_requestsCount(int count);

  /// No description provided for @adoption_statusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending Adoption'**
  String get adoption_statusPending;

  /// No description provided for @adoption_statusAdopted.
  ///
  /// In en, this message translates to:
  /// **'Adopted'**
  String get adoption_statusAdopted;

  /// No description provided for @adoption_statusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get adoption_statusCancelled;

  /// No description provided for @guest_title.
  ///
  /// In en, this message translates to:
  /// **'Enjoy the Full Experience!'**
  String get guest_title;

  /// No description provided for @guest_body.
  ///
  /// In en, this message translates to:
  /// **'Sign in to add your pets and access all features.'**
  String get guest_body;

  /// No description provided for @guest_cta.
  ///
  /// In en, this message translates to:
  /// **'Get Started Now'**
  String get guest_cta;

  /// No description provided for @pickers_chooseMonth.
  ///
  /// In en, this message translates to:
  /// **'Choose month'**
  String get pickers_chooseMonth;

  /// No description provided for @pickers_backToCalendar.
  ///
  /// In en, this message translates to:
  /// **'Back to calendar'**
  String get pickers_backToCalendar;

  /// No description provided for @pickers_selectDateRange.
  ///
  /// In en, this message translates to:
  /// **'Select a date range'**
  String get pickers_selectDateRange;

  /// No description provided for @pickers_selectPetType.
  ///
  /// In en, this message translates to:
  /// **'Select pet type'**
  String get pickers_selectPetType;

  /// No description provided for @pickers_otherCommonPets.
  ///
  /// In en, this message translates to:
  /// **'Other common pets'**
  String get pickers_otherCommonPets;

  /// No description provided for @language_english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get language_english;

  /// No description provided for @language_arabic.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get language_arabic;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
