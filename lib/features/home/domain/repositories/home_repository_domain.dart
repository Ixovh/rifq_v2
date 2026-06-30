import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/home/domain/entities/home_entity.dart';

abstract class HomeRepoDomain {

  Future<Result<HomeDataEntity, String>> getHomeData();
}