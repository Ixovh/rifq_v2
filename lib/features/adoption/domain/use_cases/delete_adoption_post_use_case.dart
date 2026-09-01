import 'package:injectable/injectable.dart';
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart';

@injectable
class DeleteAdoptionPostUseCase {
  final AdoptionRepositoryDomain _repository;

  DeleteAdoptionPostUseCase(this._repository);

  Future<void> call({
    required String adoptionPostId,
  }) {
    return _repository.deleteAdoptionPost(adoptionPostId);
  }
}