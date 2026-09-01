import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/boarding_request_entity.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_detail_entity.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_entity.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';

abstract class HomeBoardingRepoDomain {
  Future<Result<List<HomeBoardingListItemEntity>, Object>> getSitters({
    SortOption sortOption = SortOption.recommended,
    String? searchQuery,
  });

  Future<Result<HomeBoardingDetailEntity, Object>> getSitterDetail({
    required String sitterId,
  });

  Future<Result<BoardingRequestEntity?, Object>> getPendingRequest({
    required String sitterId,
  });

  Future<Result<BoardingRequestEntity, Object>> sendBoardingRequest({
    required String sitterId,
  });
}
