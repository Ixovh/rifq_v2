// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:rifq_v2/core/services/local_keys_service.dart' as _i768;
import 'package:rifq_v2/features/adoption/data/datasources/adoption_remote_data_source.dart'
    as _i89;
import 'package:rifq_v2/features/adoption/data/repositories/adoption_repository_data.dart'
    as _i92;
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart'
    as _i864;
import 'package:rifq_v2/features/adoption/domain/use_cases/adoption_use_case.dart'
    as _i77;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initAdoption({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i89.BaseAdoptionRemoteDataSource>(
      () => _i89.AdoptionRemoteDataSource(
        gh<_i768.LocalKeysService>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i864.AdoptionRepositoryDomain>(
      () =>
          _i92.AdoptionRepositoryData(gh<_i89.BaseAdoptionRemoteDataSource>()),
    );
    gh.lazySingleton<_i77.AdoptionUseCase>(
      () => _i77.AdoptionUseCase(gh<_i864.AdoptionRepositoryDomain>()),
    );
    return this;
  }
}
