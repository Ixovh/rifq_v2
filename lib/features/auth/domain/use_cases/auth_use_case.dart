import 'package:multiple_result/multiple_result.dart';
import 'package:injectable/injectable.dart';
import 'package:rifq_v2/core/errors/failure.dart';
import 'package:rifq_v2/features/auth/domain/entities/auth_entity.dart';
import 'package:rifq_v2/features/auth/domain/repositories/auth_repository_domain.dart';


@lazySingleton
class AuthUseCase {
  final AuthRepositoryDomain _repositoryData;

  AuthUseCase(this._repositoryData);

   Future<Result<AuthEntity, Failure>> getAuth() async {
    return _repositoryData.getAuth();
  }
}
