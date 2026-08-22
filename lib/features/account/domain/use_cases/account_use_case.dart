import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';
import 'package:rifq_v2/features/account/domain/repositories/account_repository_domain.dart';

@lazySingleton
class AccountUseCase {
  final AccountRepoDomain accountRepoData;

  const AccountUseCase({required this.accountRepoData});

  Future<Result<AccountDataEntity, Object>> getAccountData() async =>
      await accountRepoData.getAccountData();

  Future<Result<AccountUpdateResult, Object>> updateProfile({
    required String fullName,
    required String? phoneNumber,
    String? avatarUrl,
    required String email,
  }) async =>
      await accountRepoData.updateProfile(
        fullName: fullName,
        phoneNumber: phoneNumber,
        avatarUrl: avatarUrl,
        email: email,
      );

  Future<Result<Null, Object>> logOut() async => await accountRepoData.logOut();
}
