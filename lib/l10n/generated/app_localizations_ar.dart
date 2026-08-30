// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get common_retry => 'إعادة المحاولة';

  @override
  String get common_cancel => 'إلغاء';

  @override
  String get common_save => 'حفظ';

  @override
  String get common_next => 'التالي';

  @override
  String get common_goBack => 'رجوع';

  @override
  String get common_continue => 'متابعة';

  @override
  String get common_done => 'تم';

  @override
  String get common_confirm => 'تأكيد';

  @override
  String get common_apply => 'تطبيق';

  @override
  String get common_reset => 'إعادة تعيين';

  @override
  String get common_comingSoon => 'قريبًا';

  @override
  String get common_seeAll => 'عرض الكل';

  @override
  String get common_yourPets => 'حيواناتك الأليفة';

  @override
  String get common_email => 'البريد الإلكتروني';

  @override
  String get common_password => 'كلمة المرور';

  @override
  String get common_name => 'الاسم';

  @override
  String get common_firstName => 'الاسم الأول';

  @override
  String get common_lastName => 'اسم العائلة';

  @override
  String get common_phoneNumber => 'رقم الجوال';

  @override
  String get common_nameRequired => 'الاسم مطلوب';

  @override
  String get common_invalidEmail => 'أدخل بريدًا إلكترونيًا صحيحًا';

  @override
  String get common_gender => 'الجنس';

  @override
  String get common_age => 'العمر';

  @override
  String get common_breed => 'السلالة';

  @override
  String get common_genderMale => 'ذكر';

  @override
  String get common_genderFemale => 'أنثى';

  @override
  String get common_userFallback => 'المستخدم';

  @override
  String get common_chooseDate => 'اختر التاريخ';

  @override
  String get common_chooseDateTitle => 'اختر التاريخ';

  @override
  String get common_chooseDatesTitle => 'اختر التواريخ';

  @override
  String get common_setTimeTitle => 'اختر الوقت';

  @override
  String get common_chooseDateOfBirth => 'اختر تاريخ الميلاد';

  @override
  String get common_couldNotPickImage => 'تعذّر اختيار الصورة';

  @override
  String get common_chooseFromGallery => 'اختيار من المعرض';

  @override
  String get common_takePhoto => 'التقاط صورة';

  @override
  String get common_removePhoto => 'إزالة الصورة';

  @override
  String get common_searchHint => 'بحث...';

  @override
  String get common_date => 'التاريخ';

  @override
  String common_reviewsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '($count مراجعة)',
      many: '($count مراجعة)',
      few: '($count مراجعات)',
      two: '(مراجعتان)',
      one: '(مراجعة واحدة)',
      zero: '(لا توجد مراجعات)',
    );
    return '$_temp0';
  }

  @override
  String common_yearsExpShort(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سنة خبرة',
      many: '$count سنة خبرة',
      few: '$count سنوات خبرة',
      two: 'سنتا خبرة',
      one: 'سنة خبرة',
      zero: 'بدون خبرة',
    );
    return '$_temp0';
  }

  @override
  String common_pricePerNightSar(String price) {
    return '$price ر.س / ليلة';
  }

  @override
  String common_weightKg(String value) {
    return '$value كجم';
  }

  @override
  String common_locationDistance(String location, String distance) {
    return '$location — $distance كم';
  }

  @override
  String pet_ageMonths(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count شهر',
      many: '$count شهرًا',
      few: '$count أشهر',
      two: 'شهران',
      one: 'شهر واحد',
      zero: '$count شهر',
    );
    return '$_temp0';
  }

  @override
  String pet_ageYears(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سنة',
      many: '$count سنة',
      few: '$count سنوات',
      two: 'سنتان',
      one: 'سنة واحدة',
      zero: '$count سنة',
    );
    return '$_temp0';
  }

  @override
  String get species_cat => 'قط';

  @override
  String get species_dog => 'كلب';

  @override
  String get species_bird => 'طائر';

  @override
  String get species_falcon => 'صقر';

  @override
  String get species_rabbit => 'أرنب';

  @override
  String get species_fish => 'سمكة';

  @override
  String get species_turtle => 'سلحفاة';

  @override
  String get species_hamster => 'هامستر';

  @override
  String get species_pigeon => 'حمامة';

  @override
  String get species_horse => 'حصان';

  @override
  String get species_other => 'أخرى';

  @override
  String get welcome_title => 'مرحبًا بك في رفق';

  @override
  String get welcome_subtitle =>
      'مساحتك الموثوقة للعناية بالحيوانات الأليفة وخدماتها.';

  @override
  String get welcome_signInPrompt => 'سجّل الدخول لتواصل العناية بكل سهولة.';

  @override
  String get welcome_signIn => 'تسجيل الدخول';

  @override
  String get welcome_continueGuest => 'المتابعة كضيف';

  @override
  String get choosePath_subtitle =>
      'نجعل العناية بالحيوانات الأليفة سهلة للجميع';

  @override
  String get choosePath_prompt => 'اختر مسارك للبدء:';

  @override
  String get choosePath_petOwner => 'أمتلك حيوانًا أليفًا';

  @override
  String get choosePath_serviceProvider => 'أقدّم خدمات العناية';

  @override
  String get onboarding_title1 => 'مرحبًا بك في رفق!';

  @override
  String get onboarding_title2 => 'تابع صحة حيوانك الأليف \n بكل سهولة';

  @override
  String get onboarding_title3 => 'عناية ذكية في أي وقت';

  @override
  String get onboarding_subtitle1 =>
      'تطبيقك المتكامل للعناية والمتابعة\n ودعم كل لحظة في حياة \n حيوانك الأليف.';

  @override
  String get onboarding_subtitle2 =>
      'احفظ كل السجلات الطبية والتطعيمات\n والفحوصات منظّمة في بطاقة \n صحية ذكية واحدة.';

  @override
  String get onboarding_subtitle3 =>
      'استخدم الذكاء الاصطناعي لفحص الأعراض،\n وإيجاد العيادات القريبة والخدمات المنزلية \n والفنادق وكل ما يحتاجه حيوانك الأليف.';

  @override
  String get onboarding_getStarted => 'لنبدأ';

  @override
  String get onboarding_skip => 'تخطّي';

  @override
  String get auth_loginTab => 'تسجيل الدخول';

  @override
  String get auth_signupTab => 'إنشاء حساب';

  @override
  String get auth_loginPrompt => 'الرجاء إدخال بريدك الإلكتروني وكلمة المرور.';

  @override
  String get auth_signupPrompt => 'الرجاء إدخال بياناتك للمتابعة.';

  @override
  String get auth_emailHintError => '(مثال: username@example.com).';

  @override
  String get auth_passwordError => 'كلمة المرور غير صحيحة. حاول مرة أخرى.';

  @override
  String get auth_passwordRule =>
      'تحتوي على رقم أو رمز واحد على الأقل (مثل @، #، \$، !).';

  @override
  String get auth_forgotPassword => 'هل نسيت كلمة المرور؟';

  @override
  String get auth_loginButton => 'تسجيل الدخول';

  @override
  String get auth_signupButton => 'إنشاء حساب';

  @override
  String get auth_verifyButton => 'تأكيد';

  @override
  String get auth_agreePrefix => 'بالمتابعة، فإنك توافق على ';

  @override
  String get auth_termsAndConditions => 'الشروط والأحكام ';

  @override
  String get auth_agreeAnd => 'و';

  @override
  String get auth_privacyPolicy => 'سياسة الخصوصية';

  @override
  String get auth_resetPasswordTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get auth_resetPasswordPrompt =>
      'الرجاء إدخال كلمة المرور الجديدة للمتابعة.';

  @override
  String get auth_sendEmailPrompt =>
      'أدخل بريدك الإلكتروني للتحقق وإعادة تعيين كلمة المرور.';

  @override
  String get otp_confirmNewEmailTitle => 'تأكيد البريد الإلكتروني الجديد';

  @override
  String get otp_emailVerificationTitle => 'التحقق من البريد الإلكتروني';

  @override
  String get otp_emailUpdated => 'تم تحديث البريد الإلكتروني بنجاح';

  @override
  String get otp_sentAgain => 'تمت إعادة إرسال رمز التحقق';

  @override
  String get otp_sentNewEmailBody =>
      'لقد أرسلنا رمز تحقق إلى بريدك الإلكتروني الجديد';

  @override
  String get otp_sentEmailBody => 'لقد أرسلنا رمز تحقق إلى بريدك الإلكتروني';

  @override
  String get otp_enterBelow => 'الرجاء إدخال رمز التحقق أدناه';

  @override
  String otp_resendCodeIn(String time) {
    return 'إعادة الإرسال خلال $time';
  }

  @override
  String get otp_sending => 'جارٍ الإرسال...';

  @override
  String get otp_resend => 'إعادة إرسال الرمز';

  @override
  String get nav_askAi => 'اسأل الذكاء';

  @override
  String get nav_home => 'الرئيسية';

  @override
  String get nav_health => 'الصحة';

  @override
  String get nav_hotel => 'الفندق';

  @override
  String get nav_adoption => 'التبني';

  @override
  String get home_quickService => 'خدمة سريعة';

  @override
  String get home_clinicVisit => 'زيارة العيادة';

  @override
  String get home_petHotel => 'فندق الحيوانات';

  @override
  String get home_adopt => 'تبنَّ';

  @override
  String get home_recommendations => 'توصيات';

  @override
  String get home_welcome => 'مرحبًا';

  @override
  String get home_helloPrefix => 'مرحبًا، ';

  @override
  String get home_addPet => 'إضافة حيوان';

  @override
  String get account_securityPrivacy => 'الأمان والخصوصية';

  @override
  String get account_language => 'اللغة';

  @override
  String get account_logout => 'تسجيل الخروج';

  @override
  String get account_logoutConfirmMessage =>
      'هل أنت متأكد من رغبتك في تسجيل الخروج؟';

  @override
  String get account_noPetsYet => 'لا توجد حيوانات أليفة بعد';

  @override
  String get account_listedForAdoption => 'معروض للتبني';

  @override
  String get account_phoneRequired => 'رقم الجوال مطلوب';

  @override
  String get account_phoneInvalid9 => 'أدخل رقم جوال صحيحًا مكوّنًا من 9 أرقام';

  @override
  String get account_selectCountry => 'اختر الدولة';

  @override
  String get account_searchCountry => 'ابحث بالاسم أو الرمز';

  @override
  String get account_noCountriesFound => 'لا توجد دول مطابقة';

  @override
  String get editProfile_title => 'تعديل الملف الشخصي';

  @override
  String get editProfile_otpSentNewEmail =>
      'أرسلنا رمز تحقق إلى بريدك الإلكتروني الجديد';

  @override
  String get editProfile_profileUpdated => 'تم تحديث الملف الشخصي';

  @override
  String get editProfile_signInToEdit => 'سجّل الدخول لتعديل الملف الشخصي';

  @override
  String get editProfile_firstNameRequired => 'الاسم الأول مطلوب';

  @override
  String get editProfile_emailRequired => 'البريد الإلكتروني مطلوب';

  @override
  String get petProfile_title => 'ملف الحيوان الأليف';

  @override
  String get petProfile_tabHealthRecord => 'السجل الصحي';

  @override
  String get petProfile_tabAppointment => 'المواعيد';

  @override
  String get petProfile_noAppointments => 'لا توجد مواعيد بعد';

  @override
  String get addPet_title => 'إضافة حيوانك الأليف';

  @override
  String get addPet_success => 'تمت إضافة الحيوان الأليف بنجاح';

  @override
  String get addPet_completeAllFields => 'الرجاء إكمال جميع الحقول';

  @override
  String get addPet_profileNotFound => 'لم يتم العثور على ملف المستخدم';

  @override
  String get addPet_uploadPhoto => 'أضف صورة حيوانك الأليف';

  @override
  String get addPet_nameQuestion => 'ما اسم حيوانك الأليف؟';

  @override
  String get addPet_nameHint => 'ميلا';

  @override
  String get addPet_genderQuestion => 'ما جنس حيوانك الأليف؟';

  @override
  String get addPet_ageQuestion => 'كم عمر حيوانك الأليف؟';

  @override
  String get addPet_typeQuestion => 'ما نوع حيوانك الأليف؟';

  @override
  String get addPet_breedQuestion => 'ما سلالة حيوانك الأليف؟';

  @override
  String get addPet_breedHint => 'هاسكي';

  @override
  String addPet_ageValue(String age) {
    return 'العمر: $age';
  }

  @override
  String get editPet_title => 'تعديل بيانات الحيوان';

  @override
  String get editPet_updated => 'تم تحديث بيانات الحيوان';

  @override
  String get editPet_nameLabel => 'اسم الحيوان';

  @override
  String get editPet_breedLabel => 'سلالة الحيوان';

  @override
  String get editPet_breedRequired => 'السلالة مطلوبة';

  @override
  String get editPet_weightLabel => 'وزن الحيوان';

  @override
  String get editPet_ageLabel => 'عمر الحيوان';

  @override
  String get editPet_ageRequired => 'عمر الحيوان مطلوب';

  @override
  String get editPet_invalidWeight => 'أدخل وزنًا صحيحًا';

  @override
  String get healthRecord_chooseVisitDate => 'اختر تاريخ الزيارة';

  @override
  String get healthRecord_visitDateRequired => 'الرجاء اختيار تاريخ الزيارة';

  @override
  String get healthRecord_saved => 'تم حفظ السجل الصحي';

  @override
  String get healthRecord_addTitle => 'إضافة سجل صحي';

  @override
  String get healthRecord_fieldTitle => 'العنوان';

  @override
  String get healthRecord_titleRequired => 'العنوان مطلوب';

  @override
  String get healthRecord_fieldType => 'النوع';

  @override
  String get healthRecord_typeRequired => 'النوع مطلوب';

  @override
  String get healthRecord_fieldDescription => 'الوصف';

  @override
  String get healthRecord_fieldClinic => 'اسم العيادة';

  @override
  String get healthRecord_saveRecord => 'حفظ السجل';

  @override
  String get healthRecord_dateOfVisit => 'تاريخ الزيارة';

  @override
  String get healthRecord_empty => 'لا يوجد سجل صحي بعد';

  @override
  String get healthRecord_addNew => 'إضافة سجل صحي جديد';

  @override
  String get hotel_screenTitle => 'الفندق';

  @override
  String get hotel_bookNow => 'احجز الآن';

  @override
  String get hotel_tabHotels => 'الفنادق';

  @override
  String get hotel_tabHomeBoarding => 'الإيواء المنزلي';

  @override
  String get hotel_tabRooms => 'الغرف';

  @override
  String get hotel_tabInfo => 'معلومات الفندق';

  @override
  String get hotel_noRooms => 'لا توجد غرف مدرجة لهذا الفندق بعد.';

  @override
  String get hotel_otherServices => 'خدمات أخرى';

  @override
  String get hotel_aboutTitle => 'عن الفندق';

  @override
  String get hotel_noDescription => 'لا يوجد وصف متاح بعد.';

  @override
  String get hotel_facilities => 'المرافق';

  @override
  String get hotel_rulesTitle => 'القواعد والمتطلبات';

  @override
  String get hotel_location => 'الموقع';

  @override
  String get hotel_servicesLabel => 'الخدمات : ';

  @override
  String get hotel_includesLabel => 'يشمل :';

  @override
  String get hotel_priceUnavailable => 'السعر غير متاح';

  @override
  String get hotel_sortFilterTitle => 'الترتيب والتصفية';

  @override
  String get hotel_emptyHotels =>
      'لا توجد فنادق متاحة حاليًا — عاود التحقق قريبًا.';

  @override
  String get hotel_emptySitters =>
      'لا يوجد مقدّمو إيواء متاحون حاليًا — عاود التحقق قريبًا.';

  @override
  String get hotel_errorLoadingHotels =>
      'حدث خطأ أثناء تحميل الفنادق. حاول مرة أخرى.';

  @override
  String hotel_startingPrice(String price) {
    return 'يبدأ من $price ر.س/الليلة';
  }

  @override
  String hotel_locationDistance(String location, String distance) {
    return '$location – $distance كم';
  }

  @override
  String hotel_servicePrice(String name, String price) {
    return '$name : $price ر.س';
  }

  @override
  String hotel_roomsTotal(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count غرفة إجمالاً',
      many: '$count غرفة إجمالاً',
      few: '$count غرف إجمالاً',
      two: 'غرفتان إجمالاً',
      one: 'غرفة واحدة إجمالاً',
      zero: 'لا توجد غرف',
    );
    return '$_temp0';
  }

  @override
  String get sortOption_recommended => 'موصى به';

  @override
  String get sortOption_nearest => 'الأقرب';

  @override
  String get sortOption_topRated => 'الأعلى تقييمًا';

  @override
  String get sortOption_lowestPrice => 'الأقل سعرًا';

  @override
  String get sortOption_mostExperienced => 'الأكثر خبرة';

  @override
  String get homeBoarding_contact => 'اتصال';

  @override
  String get homeBoarding_about => 'نبذة';

  @override
  String get homeBoarding_skills => 'المهارات';

  @override
  String get homeBoarding_requestPending => 'الطلب قيد الانتظار';

  @override
  String get homeBoarding_sendRequest => 'إرسال الطلب';

  @override
  String get homeBoarding_requestSentTitle => 'تم إرسال الطلب!';

  @override
  String get homeBoarding_requestSentBody =>
      'تم إرسال طلب الإيواء المنزلي إلى المضيف.';

  @override
  String get homeBoarding_backToHome => 'العودة إلى الرئيسية';

  @override
  String get homeBoarding_errorChecking =>
      'حدث خطأ أثناء التحقق من طلباتك. حاول مرة أخرى.';

  @override
  String get homeBoarding_errorSending =>
      'حدث خطأ أثناء إرسال طلبك. حاول مرة أخرى.';

  @override
  String get homeBoarding_errorLoadingSitters =>
      'حدث خطأ أثناء تحميل مقدّمي الإيواء. حاول مرة أخرى.';

  @override
  String get homeBoarding_errorLoadingSitter =>
      'حدث خطأ أثناء تحميل بيانات مقدّم الإيواء. حاول مرة أخرى.';

  @override
  String get search_noResults => 'لا توجد نتائج.';

  @override
  String get search_startTyping => 'ابدأ الكتابة للبحث.';

  @override
  String get search_recentSearches => 'عمليات البحث الأخيرة';

  @override
  String get search_clearAll => 'مسح الكل';

  @override
  String get search_error => 'حدث خطأ أثناء البحث. حاول مرة أخرى.';

  @override
  String get booking_detailsTitle => 'تفاصيل الحجز';

  @override
  String get booking_selectRoom => 'اختر غرفة واحدة على الأقل.';

  @override
  String get booking_chooseDates => 'اختر تواريخ إقامتك.';

  @override
  String get booking_chooseTimes => 'اختر وقتَي التسليم والاستلام.';

  @override
  String get booking_chooseDatesTitle => 'اختر التواريخ';

  @override
  String get booking_dropOffTime => 'وقت التسليم';

  @override
  String get booking_pickUpTime => 'وقت الاستلام';

  @override
  String get booking_numberOfPets => 'عدد الحيوانات الأليفة';

  @override
  String get booking_servicesLabel => 'الخدمات:';

  @override
  String get booking_priceOnRequest => 'السعر عند الطلب';

  @override
  String get booking_chooseADate => 'اختر تاريخًا';

  @override
  String get booking_dropOffPickUpLabel => 'وقت التسليم ووقت الاستلام';

  @override
  String get booking_dropOff => 'التسليم';

  @override
  String get booking_pickUp => 'الاستلام';

  @override
  String get booking_confirmPayTitle => 'التأكيد والدفع';

  @override
  String get booking_yourOrder => 'طلبك';

  @override
  String get booking_roomType => 'الباقة / نوع الغرفة';

  @override
  String get booking_servicesSelected => 'الخدمات المختارة';

  @override
  String get booking_numberOfPetsOrder => 'عدد الحيوانات الأليفة';

  @override
  String get booking_stayDuration => 'مدة الإقامة / تاريخ الحجز';

  @override
  String get booking_nextDaySuffix => ' (اليوم التالي)';

  @override
  String get booking_paymentMethod => 'طريقة الدفع';

  @override
  String get booking_paymentSuccessTitle => 'تم الدفع بنجاح';

  @override
  String get booking_seeDetails => 'عرض التفاصيل';

  @override
  String get booking_receiptTitle => 'الإيصال';

  @override
  String get booking_receiptError =>
      'حدث خطأ أثناء إنشاء الإيصال. حاول مرة أخرى.';

  @override
  String get booking_status => 'الحالة';

  @override
  String get booking_priceTitle => 'السعر';

  @override
  String get booking_priceDetailsTitle => 'تفاصيل السعر';

  @override
  String get booking_downloadPdf => 'تنزيل PDF';

  @override
  String get booking_roomPrice => 'سعر الغرفة';

  @override
  String get booking_addonServices => 'خدمات إضافية';

  @override
  String get booking_totalBeforeFees => 'الإجمالي قبل الرسوم';

  @override
  String get booking_appServiceFee => 'رسوم خدمة التطبيق';

  @override
  String get booking_totalPrice => 'السعر الإجمالي';

  @override
  String get booking_errorCreating =>
      'حدث خطأ أثناء إنشاء حجزك. حاول مرة أخرى.';

  @override
  String get booking_errorAvailability =>
      'حدث خطأ أثناء التحقق من توفر الغرف. حاول مرة أخرى.';

  @override
  String booking_priceSar(String price) {
    return '$price ر.س';
  }

  @override
  String booking_amountSar(String amount) {
    return '$amount ر.س';
  }

  @override
  String booking_dropOffTimeValue(String time) {
    return 'التسليم: $time';
  }

  @override
  String booking_pickUpTimeValue(String time) {
    return 'الاستلام: $time';
  }

  @override
  String booking_nightsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ليلة',
      many: '$count ليلة',
      few: '$count ليالٍ',
      two: 'ليلتان',
      one: 'ليلة واحدة',
      zero: '$count ليلة',
    );
    return '$_temp0';
  }

  @override
  String booking_petsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حيوان أليف',
      many: '$count حيوانًا أليفًا',
      few: '$count حيوانات أليفة',
      two: 'حيوانان أليفان',
      one: 'حيوان أليف واحد',
      zero: '$count حيوان أليف',
    );
    return '$_temp0';
  }

  @override
  String booking_roomsLeft(int count, String roomName) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'تبقّت $count غرفة $roomName فقط لهذه التواريخ.',
      many: 'تبقّت $count غرفة $roomName فقط لهذه التواريخ.',
      few: 'تبقّت $count غرف $roomName فقط لهذه التواريخ.',
      two: 'تبقّت غرفتا $roomName فقط لهذه التواريخ.',
      one: 'تبقّت غرفة $roomName واحدة فقط لهذه التواريخ.',
      zero: 'لا تتوفر غرف $roomName لهذه التواريخ.',
    );
    return '$_temp0';
  }

  @override
  String get paymentMethod_applePay => 'Apple Pay';

  @override
  String get paymentMethod_visa => 'فيزا';

  @override
  String get paymentMethod_mastercard => 'ماستركارد';

  @override
  String get applePay_payWordmark => 'Pay';

  @override
  String get applePay_cardName => 'بطاقة Apple •••• 1234';

  @override
  String get applePay_confirmSideButton => 'أكّد بالزر الجانبي';

  @override
  String get adoption_screenTitle => 'التبني';

  @override
  String get guest_title => 'استمتع بالتجربة الكاملة!';

  @override
  String get guest_body =>
      'سجّل الدخول لإضافة حيواناتك الأليفة والوصول إلى جميع الميزات.';

  @override
  String get guest_cta => 'ابدأ الآن';

  @override
  String get pickers_chooseMonth => 'اختر الشهر';

  @override
  String get pickers_backToCalendar => 'العودة إلى التقويم';

  @override
  String get pickers_selectDateRange => 'اختر نطاق التواريخ';

  @override
  String get pickers_selectPetType => 'اختر نوع الحيوان';

  @override
  String get pickers_otherCommonPets => 'حيوانات أليفة شائعة أخرى';

  @override
  String get language_english => 'English';

  @override
  String get language_arabic => 'العربية';
}
