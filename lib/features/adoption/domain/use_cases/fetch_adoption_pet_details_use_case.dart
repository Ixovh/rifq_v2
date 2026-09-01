import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_details_entity.dart';
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart';

@injectable
class FetchAdoptionPetDetailsUseCase {
  final AdoptionRepositoryDomain repository;

  FetchAdoptionPetDetailsUseCase(this.repository);

  Future<Result<AdoptionPetDetailsEntity, Object>> call({
    required String adoptionPostId,
  }) {
    return repository.getAdoptionPetDetails(
      adoptionPostId: adoptionPostId,
    );
  }
}