import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/adoption/data/datasources/adoption_remote_data_source.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_model.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_pet_details_model.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_request_model.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_card_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_details_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_card_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq_v2/features/adoption/domain/entities/my_adoption_pet_entity.dart';
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
@override
Future<Result<List<MyAdoptionPetEntity>, Object>>
    getMyAdoptionPetCards() async {
  try {
    final result = await _remoteDataSource.getMyAdoptionPetCards();

    return Success(result);
  } catch (e) {
    return Error(e);
  }
}

@override
Future<void> deleteAdoptionPost(String adoptionPostId) {
  return _remoteDataSource.deleteAdoptionPost(
    adoptionPostId,
  );
}

@override
Future<Result<List<AdoptionRequestCardEntity>, Object>>
    getAdoptionRequests({
  required String adoptionPostId,
}) async {
  try {
    final result = await _remoteDataSource.getAdoptionRequests(
      adoptionPostId,
    );

    return Success(result);
  } catch (e) {
    return Error(e);
  }
}
@override
Future<Result<void, Object>> updateAdoptionRequestStatus({
  required String requestId,
  required String adoptionPostId,
  required String status,
}) async {
  try {
    await _remoteDataSource.updateAdoptionRequestStatus(
      requestId: requestId,
      status: status,
    );

    if (status == 'accepted') {
      await _remoteDataSource.updateAdoptionPostStatus(
        adoptionPostId: adoptionPostId,
        status: 'adopted',
      );
    }

    return const Success(null);
  } catch (e) {
    return Error(e);
  }
}
}