import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/core/widgets/shared/shared_in_owner_flow/shared_auth/models/auth_model.dart';
import 'package:rifq_v2/features/auth/domain/repositories/auth_repository_domain.dart';
import '../datasources/auth_data_source.dart';

@LazySingleton(as: AuthRepoDomain)
class AuthRepoData implements AuthRepoDomain {
  final BaseAuthDataSource authDataSource;

  AuthRepoData({required this.authDataSource});

  @override
  Future<Result<Null, Object>> login({
    required String email,
    required String password,
    
  }) async => await authDataSource.login(email: email, password: password);

  //
  //
  //

  @override
  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
    required String role
  }) async =>
      await authDataSource.signUp(name: name, email: email, password: password,role:role);

  //
  //
  //

  @override
  Future<Result<AuthModel, Object>> verifyAccount({
    required String email,
    required String otp,
  }) async => await authDataSource.verifyAccount(email: email, otp: otp);
  //
  //
  //

  @override
  Future<Result<Null, Object>> anonymousUser() async =>
      await authDataSource.anonymousUser();

  //
  //
  //

  @override
  Future<Result<Null, Object>> logOut() async {
    return await authDataSource.logOut();
  }
  //
  //
  //

  @override
  Future<Result<Null, Object>> resetPassword({
    required String newPassword,
  }) async {
    return await authDataSource.resetPassword(newPassword: newPassword);
  }

  //
  //
  //
  @override
  Future<Result<Null, Object>> sendPasswordResetEmail({
    required String email,
  }) async {
    return await authDataSource.sendPasswordResetEmail(email: email);
  }
}
