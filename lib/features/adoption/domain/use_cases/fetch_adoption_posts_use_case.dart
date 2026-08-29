import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_pet_card_entity.dart';
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart';

@injectable
class FetchAdoptionPetCardsUseCase {
  final AdoptionRepositoryDomain repository;

  FetchAdoptionPetCardsUseCase(this.repository);

  Future<Result<List<AdoptionPetCardEntity>, Object>> call() {
    return repository.getAdoptionPetCards();
  }
}