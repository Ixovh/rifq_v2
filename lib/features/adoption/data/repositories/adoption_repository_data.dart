import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/adoption/data/datasources/adoption_remote_data_source.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_model.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_pet_details_model.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_request_model.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_card_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_details_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart';

@LazySingleton(as: AdoptionRepositoryDomain)
class AdoptionRepositoryData implements AdoptionRepositoryDomain {
  final AdoptionRemoteDataSource _remoteDataSource;

  AdoptionRepositoryData(this._remoteDataSource);

  @override
  Future<Result<AdoptionPostEntity, Object>> createAdoptionPost({
    required AdoptionPostEntity adoptionPost,
  }) async {
    try {
      final model = AdoptionPostModel.fromEntity(adoptionPost);

      final result = await _remoteDataSource.createAdoptionPost(model);

      return Success(result);
    } catch (e) {
      return Error(e);
    }
  }

  @override
  Future<Result<List<AdoptionPetCardEntity>, Object>>
      getAdoptionPetCards() async {
    try {
      final result = await _remoteDataSource.getAdoptionPetCards();

      return Success(result);
    } catch (e) {
      return Error(e);
    }
  }


  @override
Future<Result<AdoptionPetDetailsEntity, Object>>
    getAdoptionPetDetails({
  required String adoptionPostId,
}) async {
  try {
    final result = await _remoteDataSource.getAdoptionPetDetails(
      adoptionPostId,
    );

    final model = AdoptionPetDetailsModel.fromJson(result);

    return Success(model);
  } catch (e) {
    return Error(e);
  }
}

@override
Future<Result<AdoptionRequestEntity, Object>> createAdoptionRequest({
  required AdoptionRequestEntity adoptionRequest,
}) async {
  try {
    final model = AdoptionRequestModel.fromEntity(adoptionRequest);

    final result = await _remoteDataSource.createAdoptionRequest(model);

    return Success(result);
  } catch (e) {
    return Error(e);
  }
}

}