import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';

abstract class AdoptionRepositoryDomain {
  Future<Result<AdoptionPostEntity, Object>> createAdoptionPost({
    required AdoptionPostEntity adoptionPost,
  });
}