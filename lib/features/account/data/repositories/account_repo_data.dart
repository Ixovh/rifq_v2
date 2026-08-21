import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';
import 'package:rifq_v2/features/account/domain/repositories/account_repository_domain.dart';
import '../datasources/account_data_source.dart';

@LazySingleton(as: AccountRepoDomain)
class AccountRepoData implements AccountRepoDomain {
  final BaseAccountDataSource accountDataSource;

  AccountRepoData({required this.accountDataSource});

  @override
  Future<Result<AccountDataEntity, Object>> getAccountData() async =>
      await accountDataSource.getAccountData();

  @override
  Future<Result<AccountEntity, Object>> updateProfile({
    required String fullName,
    required String? phoneNumber,
    String? avatarUrl,
  }) async =>
      await accountDataSource.updateProfile(
        fullName: fullName,
        phoneNumber: phoneNumber,
        avatarUrl: avatarUrl,
      );

  @override
  Future<Result<Null, Object>> logOut() async =>
      await accountDataSource.logOut();
}
