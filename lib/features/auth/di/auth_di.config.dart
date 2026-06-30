// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:get_storage/get_storage.dart' as _i792;
import 'package:injectable/injectable.dart' as _i526;
import 'package:rifq_v2/features/auth/data/datasources/auth_data_source.dart'
    as _i1056;
import 'package:rifq_v2/features/auth/data/repositories/auth_repo_data.dart'
    as _i389;
import 'package:rifq_v2/features/auth/domain/repositories/auth_repository_domain.dart'
    as _i42;
import 'package:rifq_v2/features/auth/domain/use_cases/auth_use_case.dart'
    as _i543;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initAuth({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i1056.BaseAuthDataSource>(
      () => _i1056.SubaBaseDataSource(
        supabase: gh<_i454.SupabaseClient>(),
        box: gh<_i792.GetStorage>(),
      ),
    );
    gh.lazySingleton<_i42.AuthRepoDomain>(
      () => _i389.AuthRepoData(authDataSource: gh<_i1056.BaseAuthDataSource>()),
    );
    gh.lazySingleton<_i543.AuthUseCase>(
      () => _i543.AuthUseCase(authRepoData: gh<_i42.AuthRepoDomain>()),
    );
    return this;
  }
}
