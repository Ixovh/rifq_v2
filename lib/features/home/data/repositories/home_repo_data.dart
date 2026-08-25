import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/home/data/datasources/home_data_source.dart';
import 'package:rifq_v2/features/home/domain/entities/home_entity.dart';
import 'package:rifq_v2/features/home/domain/repositories/home_repository_domain.dart';

@LazySingleton(as: HomeRepoDomain)
class HomeRepoData implements HomeRepoDomain {
  final BaseHomeDataSource homeDataSource;

  HomeRepoData({required this.homeDataSource});

  @override
  Future<Result<HomeDataEntity, Object>> getHomeData({
    bool forceRefresh = false,
  }) async => await homeDataSource.getHomeData(forceRefresh: forceRefresh);
}
