import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_detail_entity.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_entity.dart';
import 'package:rifq_v2/features/home_boarding/domain/repositories/home_boarding_repository_domain.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';

@lazySingleton
class HomeBoardingUseCase {
  final HomeBoardingRepoDomain homeBoardingRepoData;

  const HomeBoardingUseCase({required this.homeBoardingRepoData});

  Future<Result<List<HomeBoardingListItemEntity>, Object>> getSitters({
    SortOption sortOption = SortOption.recommended,
    String? searchQuery,
  }) async => await homeBoardingRepoData.getSitters(
    sortOption: sortOption,
    searchQuery: searchQuery,
  );

  Future<Result<HomeBoardingDetailEntity, Object>> getSitterDetail({
    required String sitterId,
  }) async => await homeBoardingRepoData.getSitterDetail(sitterId: sitterId);
}
