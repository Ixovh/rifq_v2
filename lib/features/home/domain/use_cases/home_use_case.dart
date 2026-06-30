import 'package:injectable/injectable.dart';


import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/home/domain/entities/home_entity.dart';
import 'package:rifq_v2/features/home/domain/repositories/home_repository_domain.dart';

@injectable
class GetHomeDataUseCase {
  final HomeRepoDomain repo;

  GetHomeDataUseCase(this.repo);

  Future<Result<HomeDataEntity, String>> getHomeData() async {
    return await repo.getHomeData();
  }
}