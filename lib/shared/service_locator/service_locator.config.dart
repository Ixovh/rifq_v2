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

import '../../features/account/data/datasources/account_data_source.dart'
    as _i1012;
import '../../features/account/data/repositories/account_repo_data.dart'
    as _i1013;
import '../../features/account/domain/repositories/account_repository_domain.dart'
    as _i533;
import '../../features/account/domain/use_cases/account_use_case.dart' as _i803;
import '../../features/account/presentation/cubit/account_cubit.dart' as _i439;
import '../../features/add_pet/data/datasources/add_pet_data_source.dart'
    as _i734;
import '../../features/add_pet/data/repositories/add_pet_repo_data.dart'
    as _i63;
import '../../features/add_pet/domain/repositories/add_pet_repo_domain.dart'
    as _i52;
import '../../features/add_pet/domain/use_cases/add_pet_use_case.dart' as _i667;
import '../../features/add_pet/presentation/cubit/add_pet_cubit.dart' as _i493;
import '../../features/adoption/data/datasources/adoption_remote_data_source.dart'
    as _i956;
import '../../features/adoption/data/repositories/adoption_repository_data.dart'
    as _i321;
import '../../features/adoption/domain/repositories/adoption_repository_domain.dart'
    as _i785;
import '../../features/adoption/domain/use_cases/create_adoption_post_use_case.dart'
    as _i824;
import '../../features/adoption/domain/use_cases/create_adoption_request_use_case.dart'
    as _i374;
import '../../features/adoption/domain/use_cases/delete_adoption_post_use_case.dart'
    as _i813;
import '../../features/adoption/domain/use_cases/fetch_adoption_pet_details_use_case.dart'
    as _i729;
import '../../features/adoption/domain/use_cases/fetch_adoption_posts_use_case.dart'
    as _i425;
import '../../features/adoption/domain/use_cases/fetch_my_adoption_pet_cards_use_case.dart'
    as _i939;
import '../../features/adoption/presentation/cubit/adoption_cubit.dart'
    as _i431;
import '../../features/auth/data/datasources/auth_data_source.dart' as _i970;
import '../../features/auth/data/repositories/auth_repo_data.dart' as _i400;
import '../../features/auth/domain/repositories/auth_repository_domain.dart'
    as _i998;
import '../../features/auth/domain/use_cases/auth_use_case.dart' as _i283;
import '../../features/edit_pet/data/datasources/edit_pet_data_source.dart'
    as _i897;
import '../../features/edit_pet/data/repositories/edit_pet_repo_data.dart'
    as _i76;
import '../../features/edit_pet/domain/repositories/edit_pet_repository_domain.dart'
    as _i628;
import '../../features/edit_pet/domain/use_cases/edit_pet_use_case.dart'
    as _i430;
import '../../features/edit_pet/presentation/cubit/edit_pet_cubit.dart'
    as _i578;
import '../../features/health_record/data/datasources/health_record_data_source.dart'
    as _i664;
import '../../features/health_record/data/repositories/health_record_repo_data.dart'
    as _i589;
import '../../features/health_record/domain/repositories/health_record_repository_domain.dart'
    as _i375;
import '../../features/health_record/domain/use_cases/health_record_use_case.dart'
    as _i653;
import '../../features/health_record/presentation/cubit/health_record_cubit.dart'
    as _i1036;
import '../../features/home/data/datasources/home_data_source.dart' as _i426;
import '../../features/home/data/repositories/home_repo_data.dart' as _i475;
import '../../features/home/domain/repositories/home_repository_domain.dart'
    as _i257;
import '../../features/home/domain/use_cases/home_use_case.dart' as _i933;
import '../../features/home/presentation/cubit/home_cubit.dart' as _i9;
import '../networking/dio_client.dart' as _i201;
import '../storage_service/local_keys_service.dart' as _i261;
import 'shared/main_dependencies.dart' as _i1014;

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
    gh.lazySingleton<_i201.DioClient>(() => _i201.DioClient());
    gh.lazySingleton<_i956.AdoptionRemoteDataSource>(
      () => _i956.AdoptionRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i734.BaseAddPetDataSource>(
      () => _i734.AddPetDataSource(gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i970.BaseAuthDataSource>(
      () => _i970.SubaBaseDataSource(
        supabase: gh<_i454.SupabaseClient>(),
        box: gh<_i792.GetStorage>(),
      ),
    );
    gh.lazySingleton<_i426.BaseHomeDataSource>(
      () => _i426.HomeDataSource(supabase: gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i897.BaseEditPetDataSource>(
      () => _i897.EditPetDataSource(supabase: gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i257.HomeRepoDomain>(
      () => _i475.HomeRepoData(homeDataSource: gh<_i426.BaseHomeDataSource>()),
    );
    gh.lazySingleton<_i1012.BaseAccountDataSource>(
      () => _i1012.AccountDataSource(supabase: gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i664.BaseHealthRecordDataSource>(
      () => _i664.HealthRecordDataSource(supabase: gh<_i454.SupabaseClient>()),
    );
    gh.lazySingleton<_i998.AuthRepoDomain>(
      () => _i400.AuthRepoData(authDataSource: gh<_i970.BaseAuthDataSource>()),
    );
    gh.lazySingleton<_i52.AddPetRepoDomain>(
      () => _i63.AddPetRepoData(gh<_i734.BaseAddPetDataSource>()),
    );
    gh.lazySingleton<_i933.HomeUseCase>(
      () => _i933.HomeUseCase(homeRepoData: gh<_i257.HomeRepoDomain>()),
    );
    gh.lazySingleton<_i785.AdoptionRepositoryDomain>(
      () => _i321.AdoptionRepositoryData(gh<_i956.AdoptionRemoteDataSource>()),
    );
    gh.lazySingleton<_i283.AuthUseCase>(
      () => _i283.AuthUseCase(authRepoData: gh<_i998.AuthRepoDomain>()),
    );
    gh.lazySingleton<_i628.EditPetRepoDomain>(
      () => _i76.EditPetRepoData(
        editPetDataSource: gh<_i897.BaseEditPetDataSource>(),
      ),
    );
    gh.lazySingleton<_i375.HealthRecordRepoDomain>(
      () => _i589.HealthRecordRepoData(
        healthRecordDataSource: gh<_i664.BaseHealthRecordDataSource>(),
      ),
    );
    gh.lazySingleton<_i533.AccountRepoDomain>(
      () => _i1013.AccountRepoData(
        accountDataSource: gh<_i1012.BaseAccountDataSource>(),
      ),
    );
    gh.factory<_i824.CreateAdoptionPostUseCase>(
      () =>
          _i824.CreateAdoptionPostUseCase(gh<_i785.AdoptionRepositoryDomain>()),
    );
    gh.factory<_i374.CreateAdoptionRequestUseCase>(
      () => _i374.CreateAdoptionRequestUseCase(
        gh<_i785.AdoptionRepositoryDomain>(),
      ),
    );
    gh.factory<_i729.FetchAdoptionPetDetailsUseCase>(
      () => _i729.FetchAdoptionPetDetailsUseCase(
        gh<_i785.AdoptionRepositoryDomain>(),
      ),
    );
    gh.factory<_i425.FetchAdoptionPetCardsUseCase>(
      () => _i425.FetchAdoptionPetCardsUseCase(
        gh<_i785.AdoptionRepositoryDomain>(),
      ),
    );
    gh.lazySingleton<_i803.AccountUseCase>(
      () =>
          _i803.AccountUseCase(accountRepoData: gh<_i533.AccountRepoDomain>()),
    );
    gh.lazySingleton<_i653.HealthRecordUseCase>(
      () => _i653.HealthRecordUseCase(
        healthRecordRepoData: gh<_i375.HealthRecordRepoDomain>(),
      ),
    );
    gh.lazySingleton<_i430.EditPetUseCase>(
      () =>
          _i430.EditPetUseCase(editPetRepoData: gh<_i628.EditPetRepoDomain>()),
    );
    gh.factory<_i667.AddPetUseCase>(
      () => _i667.AddPetUseCase(gh<_i52.AddPetRepoDomain>()),
    );
    gh.factory<_i813.DeleteAdoptionPostUseCase>(
      () =>
          _i813.DeleteAdoptionPostUseCase(gh<_i785.AdoptionRepositoryDomain>()),
    );
    gh.factory<_i939.FetchMyAdoptionPetCardsUseCase>(
      () => _i939.FetchMyAdoptionPetCardsUseCase(
        gh<_i785.AdoptionRepositoryDomain>(),
      ),
    );
    gh.factory<_i439.AccountCubit>(
      () => _i439.AccountCubit(gh<_i803.AccountUseCase>()),
    );
    gh.factory<_i9.HomeCubit>(() => _i9.HomeCubit(gh<_i933.HomeUseCase>()));
    gh.factory<_i493.AddPetCubit>(
      () => _i493.AddPetCubit(gh<_i667.AddPetUseCase>()),
    );
    gh.factory<_i1036.HealthRecordCubit>(
      () => _i1036.HealthRecordCubit(gh<_i653.HealthRecordUseCase>()),
    );
    gh.factory<_i578.EditPetCubit>(
      () => _i578.EditPetCubit(gh<_i430.EditPetUseCase>()),
    );
    gh.factory<_i431.AdoptionCubit>(
      () => _i431.AdoptionCubit(
        gh<_i824.CreateAdoptionPostUseCase>(),
        gh<_i425.FetchAdoptionPetCardsUseCase>(),
        gh<_i729.FetchAdoptionPetDetailsUseCase>(),
        gh<_i374.CreateAdoptionRequestUseCase>(),
        gh<_i939.FetchMyAdoptionPetCardsUseCase>(),
        gh<_i813.DeleteAdoptionPostUseCase>(),
      ),
    );
    gh.singleton<_i261.LocalKeysService>(() => _i261.LocalKeysService());
    return this;
  }
}

class _$ThirdPartyModule extends _i1014.ThirdPartyModule {}
