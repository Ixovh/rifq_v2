import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart';

@injectable
class UpdateAdoptionRequestStatusUseCase {
  final AdoptionRepositoryDomain repository;

  UpdateAdoptionRequestStatusUseCase(this.repository);

  Future<Result<void, Object>> call({
    required String requestId,
    required String adoptionPostId,
    required String status,
  }) {
    return repository.updateAdoptionRequestStatus(
      requestId: requestId,
      adoptionPostId: adoptionPostId,
      status: status,
    );
  }
}