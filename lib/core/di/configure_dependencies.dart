import 'package:get_it/get_it.dart';
import 'package:rifq_v2/core/di/configure_dependencies.config.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/auth/di/auth_di.dart';
import 'package:rifq_v2/features/adoption/di/adoption_di.dart';

@InjectableInit(
  initializerName: 'init', 
  preferRelativeImports: true,
  asExtension: true, 
  generateForDir: ['lib/core'],
)

Future<void> configureDependencies() async {
  final getIt = GetIt.instance;
  getIt.init();
    configureAuth(getIt);
    configureAdoption(getIt);
}
