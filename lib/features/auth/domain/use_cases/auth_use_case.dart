import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/core/widgets/shared/shared_in_owner_flow/shared_auth/entities/auth_entity.dart';
import 'package:rifq_v2/features/auth/domain/repositories/auth_repository_domain.dart';


@lazySingleton
class AuthUseCase {
  final AuthRepoDomain authRepoData;

  const AuthUseCase({required this.authRepoData});

  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
    required String role
  }) async =>
      await authRepoData.signUp(name: name, email: email, password: password, role: role,);

  //---------
  Future<Result<Null, Object>> login({
    required String email,
    required String password,
  }) async => await authRepoData.login(email: email, password: password);

  //---------
  Future<Result<AuthEntity, Object>> verifyAccount({
    required String email,
    required String otp,
  }) async {
    return await authRepoData.verifyAccount(email: email, otp: otp);
  }

  //---------
  Future<Result<Null, Object>> anonymousUser() async {
    return await authRepoData.anonymousUser();
  }

  //---------
  Future<Result<Null, Object>> logOut() async {
    return await authRepoData.logOut();
  }

  //---------
  Future<Result<Null, Object>> resetPassword({
    required String newPassword,
  }) async => await authRepoData.resetPassword(newPassword: newPassword);

  //---------
  Future<Result<Null, Object>> sendPasswordResetEmail({
    required String email,
  }) async => await authRepoData.sendPasswordResetEmail(email: email);
}
