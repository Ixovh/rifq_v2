import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/home/domain/entities/home_entity.dart';
import 'package:rifq_v2/features/home/domain/repositories/home_repository_domain.dart';

@lazySingleton
class HomeUseCase {
  final HomeRepoDomain homeRepoData;

  const HomeUseCase({required this.homeRepoData});

  Future<Result<HomeDataEntity, Object>> getHomeData({
    bool forceRefresh = false,
  }) async => await homeRepoData.getHomeData(forceRefresh: forceRefresh);
}
