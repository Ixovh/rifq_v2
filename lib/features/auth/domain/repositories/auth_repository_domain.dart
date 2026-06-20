import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/core/errors/failure.dart';
import 'package:rifq_v2/features/auth/domain/entities/auth_entity.dart';

abstract class AuthRepositoryDomain {
    Future<Result<AuthEntity, Failure>> getAuth();
}
