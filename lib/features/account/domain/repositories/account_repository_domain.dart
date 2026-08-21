import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';

abstract class AccountRepoDomain {
  Future<Result<AccountDataEntity, Object>> getAccountData();

  Future<Result<AccountEntity, Object>> updateProfile({
    required String fullName,
    required String? phoneNumber,
    String? avatarUrl,
  });

  Future<Result<Null, Object>> logOut();
}
