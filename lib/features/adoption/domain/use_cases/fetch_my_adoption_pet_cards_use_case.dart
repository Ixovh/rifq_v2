import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/adoption/domain/entities/my_adoption_pet_entity.dart';
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart';

@injectable
class FetchMyAdoptionPetCardsUseCase {
  final AdoptionRepositoryDomain _repository;

  FetchMyAdoptionPetCardsUseCase(this._repository);

  Future<Result<List<MyAdoptionPetEntity>, Object>> call() {
    return _repository.getMyAdoptionPetCards();
  }
}