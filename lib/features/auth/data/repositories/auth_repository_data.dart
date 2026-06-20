
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/core/errors/network_exceptions.dart';
import 'package:rifq_v2/core/errors/failure.dart';
import 'package:rifq_v2/features/auth/domain/entities/auth_entity.dart';

import 'package:rifq_v2/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:rifq_v2/features/auth/data/models/auth_model.dart';
import 'package:rifq_v2/features/auth/domain/repositories/auth_repository_domain.dart';

@LazySingleton(as: AuthRepositoryDomain)
class AuthRepositoryData implements AuthRepositoryDomain{
  final BaseAuthRemoteDataSource remoteDataSource;


  AuthRepositoryData(this.remoteDataSource);

@override
  Future<Result<AuthEntity, Failure>> getAuth() async {
    try {
      final response = await remoteDataSource.getAuth();
      return Success(response.toEntity());
    } catch (error) {
      return Error(FailureExceptions.getException(error));
    }
  }
}
