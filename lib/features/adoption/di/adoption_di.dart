import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'adoption_di.config.dart'; 

@InjectableInit(
  initializerName: 'initAdoption',
   // Optional: specify the directory to scan for injectable annotations
  generateForDir: ['lib/features/adoption'],
)
void configureAdoption(GetIt getIt) {
  getIt.initAdoption();
}
