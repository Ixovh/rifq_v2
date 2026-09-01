import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_card_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_details_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_card_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/my_adoption_pet_entity.dart';

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
Future<Result<List<MyAdoptionPetEntity>, Object>>
    getMyAdoptionPetCards();


    Future<void> deleteAdoptionPost(String adoptionPostId);

    Future<Result<List<AdoptionRequestCardEntity>, Object>>
    getAdoptionRequests({
  required String adoptionPostId,
});

Future<Result<void, Object>> updateAdoptionRequestStatus({
  required String requestId,
  required String adoptionPostId,
  required String status,
});

  Future<Result<String?, Object>> getMyAdoptionRequestStatus({
    required String adoptionPostId,
  });
}