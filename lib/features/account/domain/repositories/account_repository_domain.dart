import 'dart:io';

import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/features/account/domain/entities/account_entity.dart';

abstract class AccountRepoDomain {
  Future<Result<AccountDataEntity, Object>> getAccountData({
    bool forceRefresh = false,
  });

  Future<Result<AccountUpdateResult, Object>> updateProfile({
    required String fullName,
    required String? phoneNumber,
    String? avatarUrl,
    File? imageFile,
    bool removeImage = false,
    required String email,
  });

  Future<Result<Null, Object>> logOut();
}
