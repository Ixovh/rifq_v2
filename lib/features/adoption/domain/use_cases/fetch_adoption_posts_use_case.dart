import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart';

@injectable
class FetchAdoptionPostsUseCase {
  final AdoptionRepositoryDomain repository;

  FetchAdoptionPostsUseCase(this.repository);

  Future<Result<List<AdoptionPostEntity>, Object>> call() {
    return repository.getAdoptionPosts();
  }
}