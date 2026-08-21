import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/auth/domain/entities/auth_entity.dart';


abstract class AuthRepoDomain {
  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
     required String role
  });

  //---------
  Future<Result<Null, Object>> login({
    required String email,
    required String password,
  });

  //---------
  Future<Result<AuthEntity, Object>> verifyAccount({
    required String email,
    required String otp,
  });

  //---------
  Future<Result<Null, Object>> anonymousUser();
  
  //---------
  Future<Result<Null, Object>> logOut();
  
  //---------
  Future<Result<Null, Object>> resetPassword({
    required String newPassword,
  });
  
  //---------
  Future<Result<Null, Object>> sendPasswordResetEmail({
    required String email,
  });

}
