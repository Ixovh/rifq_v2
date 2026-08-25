import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart';

@injectable
class CreateAdoptionPostUseCase {
  final AdoptionRepositoryDomain repository;

  CreateAdoptionPostUseCase(this.repository);

  Future<Result<AdoptionPostEntity, Object>> call({
    required AdoptionPostEntity adoptionPost,
  }) {
    return repository.createAdoptionPost(
      adoptionPost: adoptionPost,
    );
  }
}