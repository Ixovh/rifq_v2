
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/core/errors/network_exceptions.dart';
import 'package:rifq_v2/core/errors/failure.dart';
import 'package:rifq_v2/features/adoption/domain/entities/adoption_entity.dart';

import 'package:rifq_v2/features/adoption/data/datasources/adoption_remote_data_source.dart';
import 'package:rifq_v2/features/adoption/data/models/adoption_model.dart';
import 'package:rifq_v2/features/adoption/domain/repositories/adoption_repository_domain.dart';

@LazySingleton(as: AdoptionRepositoryDomain)
class AdoptionRepositoryData implements AdoptionRepositoryDomain{
  final BaseAdoptionRemoteDataSource remoteDataSource;


  AdoptionRepositoryData(this.remoteDataSource);

@override
  Future<Result<AdoptionEntity, Failure>> getAdoption() async {
    try {
      final response = await remoteDataSource.getAdoption();
      return Success(response.toEntity());
    } catch (error) {
      return Error(FailureExceptions.getException(error));
    }
  }
}
