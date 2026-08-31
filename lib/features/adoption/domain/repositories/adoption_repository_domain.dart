import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_card_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_details_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_entity.dart';

abstract class AdoptionRepositoryDomain {
  Future<Result<AdoptionPostEntity, Object>> createAdoptionPost({
    required AdoptionPostEntity adoptionPost,
  });

  Future<Result<List<AdoptionPetCardEntity>, Object>>
      getAdoptionPetCards();


      Future<Result<AdoptionPetDetailsEntity, Object>>
    getAdoptionPetDetails({
  required String adoptionPostId,
});


Future<Result<AdoptionRequestEntity, Object>> createAdoptionRequest({
  required AdoptionRequestEntity adoptionRequest,
});
}