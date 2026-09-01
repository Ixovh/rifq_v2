import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart';

@injectable
class FetchMyAdoptionRequestStatusUseCase {
  final AdoptionRepositoryDomain repository;

  FetchMyAdoptionRequestStatusUseCase(this.repository);

  Future<Result<String?, Object>> call({
    required String adoptionPostId,
  }) {
    return repository.getMyAdoptionRequestStatus(
      adoptionPostId: adoptionPostId,
    );
  }
}
