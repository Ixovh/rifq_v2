import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_request_card_entity.dart';
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart';

@injectable
class FetchAdoptionRequestsUseCase {
  final AdoptionRepositoryDomain repository;

  FetchAdoptionRequestsUseCase(this.repository);

  Future<Result<List<AdoptionRequestCardEntity>, Object>> call({
    required String adoptionPostId,
  }) {
    return repository.getAdoptionRequests(
      adoptionPostId: adoptionPostId,
    );
  }
}