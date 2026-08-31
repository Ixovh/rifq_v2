import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_entity.dart';
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart';

@injectable
class CreateAdoptionRequestUseCase {
  final AdoptionRepositoryDomain repository;

  CreateAdoptionRequestUseCase(this.repository);

  Future<Result<AdoptionRequestEntity, Object>> call({
    required AdoptionRequestEntity adoptionRequest,
  }) {
    return repository.createAdoptionRequest(
      adoptionRequest: adoptionRequest,
    );
  }
}