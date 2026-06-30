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
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

import '../../features/add_pet/data/datasources/add_pet_data_source.dart'
    as _i734;
import '../../features/add_pet/data/repositories/add_pet_repo_data.dart'
    as _i63;
import '../../features/add_pet/domain/repositories/add_pet_repo_domain.dart'
    as _i52;
import '../../features/add_pet/domain/usecases/add_pet_use_case.dart' as _i151;
import '../../features/add_pet/presentation/cubit/add_pet_cubit.dart' as _i493;
import '../../features/adoption/data/datasources/adoption_remote_data_source.dart'
    as _i956;
import '../../features/adoption/data/repositories/adoption_repository_data.dart'
    as _i321;
import '../../features/adoption/domain/repositories/adoption_repository_domain.dart'
    as _i785;
import '../../features/adoption/domain/use_cases/adoption_use_case.dart'
    as _i367;
import '../../features/auth/data/datasources/auth_data_source.dart' as _i970;
import '../../features/auth/data/repositories/auth_repo_data.dart' as _i400;
import '../../features/auth/domain/repositories/auth_repository_domain.dart'
    as _i998;
import '../../features/auth/domain/use_cases/auth_use_case.dart' as _i283;
import '../../features/home/data/datasources/home_remote_data_source.dart'
    as _i362;
import '../../features/home/data/repositories/home_repository_data.dart'
    as _i145;
import '../../features/home/domain/repositories/home_repository_domain.dart'
    as _i257;
import '../../features/home/domain/use_cases/home_use_case.dart' as _i933;
import '../../features/home/presentation/cubit/home_cubit.dart' as _i9;
import '../network/dio_client.dart' as _i667;
import '../services/local_keys_service.dart' as _i945;
import 'third_part.dart' as _i423;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final thirdPartyModule = _$ThirdPartyModule();
    gh.singleton<_i792.GetStorage>(() => thirdPartyModule.storage);
    gh.singleton<_i454.SupabaseClient>(() => thirdPartyModule.supabaseClient);
    gh.lazySingleton<_i667.DioClient>(() => _i667.DioClient());
    gh.lazySingleton<_i734.BaseAddPetDataSource>(
      () => _i734.AddPetDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i956.BaseAdoptionRemoteDataSource>(
      () => _i956.AdoptionRemoteDataSource(
        gh<_i945.LocalKeysService>(),
        gh<_i454.SupabaseClient>(),
      ),
    );
    gh.lazySingleton<_i785.AdoptionRepositoryDomain>(
      () => _i321.AdoptionRepositoryData(
        gh<_i956.BaseAdoptionRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i362.BaseHomeDataSource>(
      () => _i362.HomeDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i970.BaseAuthDataSource>(
      () => _i970.SubaBaseDataSource(
        supabase: gh<_i454.SupabaseClient>(),
        box: gh<_i792.GetStorage>(),
      ),
    );
    gh.lazySingleton<_i998.AuthRepoDomain>(
      () => _i400.AuthRepoData(authDataSource: gh<_i970.BaseAuthDataSource>()),
    );
    gh.lazySingleton<_i367.AdoptionUseCase>(
      () => _i367.AdoptionUseCase(gh<_i785.AdoptionRepositoryDomain>()),
    );
    gh.lazySingleton<_i52.AddPetRepoDomain>(
      () => _i63.AddPetRepoData(gh<_i734.BaseAddPetDataSource>()),
    );
    gh.lazySingleton<_i257.HomeRepoDomain>(
      () => _i145.HomeRepoImpl(gh<_i362.BaseHomeDataSource>()),
    );
    gh.factory<_i933.GetHomeDataUseCase>(
      () => _i933.GetHomeDataUseCase(gh<_i257.HomeRepoDomain>()),
    );
    gh.lazySingleton<_i283.AuthUseCase>(
      () => _i283.AuthUseCase(authRepoData: gh<_i998.AuthRepoDomain>()),
    );
    gh.factory<_i151.AddPetUseCase>(
      () => _i151.AddPetUseCase(gh<_i52.AddPetRepoDomain>()),
    );
    gh.factory<_i9.HomeCubit>(
      () => _i9.HomeCubit(gh<_i933.GetHomeDataUseCase>()),
    );
    gh.factory<_i493.AddPetCubit>(
      () => _i493.AddPetCubit(gh<_i151.AddPetUseCase>()),
    );
    gh.singleton<_i945.LocalKeysService>(() => _i945.LocalKeysService());
    return this;
  }
}

class _$ThirdPartyModule extends _i423.ThirdPartyModule {}
