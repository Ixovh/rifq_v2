import 'package:multiple_result/multiple_result.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/core/errors/failure.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart';


@lazySingleton
class AdoptionUseCase {
  final AdoptionRepositoryDomain _repositoryData;

  AdoptionUseCase(this._repositoryData);

   Future<Result<AdoptionEntity, Failure>> getAdoption() async {
    return _repositoryData.getAdoption();
  }
}
