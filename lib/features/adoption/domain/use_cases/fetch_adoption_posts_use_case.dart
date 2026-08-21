import 'package:injectable/injectable.dart';
import '../entities/adoption_entity.dart';
import '../repositories/adoption_repository_domain.dart';

@injectable
class FetchAdoptionPostsUseCase {
  final AdoptionRepositoryDomain repository;

  FetchAdoptionPostsUseCase(this.repository);

  Future<List<AdoptionPostEntity>> call() async {
    return await repository.fetchAvailableAdoptionPosts();
  }
}