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
import 'package:rifq_v2/features/adoption/data/datasources/adoption_remote_data_source.dart'
    as _i89;
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart'
    as _i864;
import 'package:rifq_v2/features/adoption/domain/use_cases/create_adoption_post_use_case.dart'
    as _i621;
import 'package:rifq_v2/features/adoption/domain/use_cases/fetch_adoption_posts_use_case.dart'
    as _i772;
import 'package:rifq_v2/features/adoption/presentation/cubit/adoption_cubit.dart'
    as _i1045;
import 'package:supabase_flutter/supabase_flutter.dart' as _i454;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt initAdoption({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i89.AdoptionRemoteDataSource>(
      () => _i89.AdoptionRemoteDataSourceImpl(gh<_i454.SupabaseClient>()),
    );
    gh.factory<_i621.CreateAdoptionPostUseCase>(
      () =>
          _i621.CreateAdoptionPostUseCase(gh<_i864.AdoptionRepositoryDomain>()),
    );
    gh.factory<_i772.FetchAdoptionPostsUseCase>(
      () =>
          _i772.FetchAdoptionPostsUseCase(gh<_i864.AdoptionRepositoryDomain>()),
    );
    gh.factory<_i1045.AdoptionCubit>(
      () => _i1045.AdoptionCubit(
        gh<_i772.FetchAdoptionPostsUseCase>(),
        gh<_i621.CreateAdoptionPostUseCase>(),
      ),
    );
    return this;
  }
}
