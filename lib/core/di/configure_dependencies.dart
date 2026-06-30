// import 'package:get_it/get_it.dart';
// import 'package:rifq_v2/core/di/configure_dependencies.config.dart';
// import 'package:injectable/injectable.dart';
// import 'package:rifq_v2/features/auth/di/auth_di.dart';
// import 'package:rifq_v2/features/adoption/di/adoption_di.dart';

// @InjectableInit(
//   initializerName: 'init', 
//   preferRelativeImports: true,
//   asExtension: true, 
//   generateForDir: ['lib/core'],
// )

// Future<void> configureDependencies() async {
//   final getIt = GetIt.instance;
//   getIt.init();
//     configureAuth(getIt);
//     configureAdoption(getIt);
//     // configureOnboarding(getIt);
//     configureHome(getIt);
// }

import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rifq_v2/core/di/configure_dependencies.config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'configure_dependencies.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['url_supabase'].toString(),
    anonKey: dotenv.env['key_supabase'].toString(),
  );

  await GetStorage.init();
  getIt.init();
}