import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/home_boarding/data/datasources/home_boarding_data_source.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_detail_entity.dart';
import 'package:rifq_v2/features/home_boarding/domain/entities/home_boarding_entity.dart';
import 'package:rifq_v2/features/home_boarding/domain/repositories/home_boarding_repository_domain.dart';
import 'package:rifq_v2/shared/constants/app_enums.dart';

@LazySingleton(as: HomeBoardingRepoDomain)
class HomeBoardingRepoData implements HomeBoardingRepoDomain {
  final BaseHomeBoardingDataSource homeBoardingDataSource;

  HomeBoardingRepoData({required this.homeBoardingDataSource});

  @override
  Future<Result<List<HomeBoardingListItemEntity>, Object>> getSitters({
    SortOption sortOption = SortOption.recommended,
    String? searchQuery,
  }) async => await homeBoardingDataSource.getSitters(
    sortOption: sortOption,
    searchQuery: searchQuery,
  );

  @override
  Future<Result<HomeBoardingDetailEntity, Object>> getSitterDetail({
    required String sitterId,
  }) async => await homeBoardingDataSource.getSitterDetail(sitterId: sitterId);
}
