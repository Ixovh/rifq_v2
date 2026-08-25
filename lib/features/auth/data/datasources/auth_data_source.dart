import 'package:get_storage/get_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:rifq_v2/shared/constants/otp_purpose.dart';
import 'package:rifq_v2/shared/errors/custome_exception.dart';
import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
import 'package:rifq_v2/features/auth/data/models/auth_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class BaseAuthDataSource {
  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
    required String role,
  });

  Future<Result<Null, Object>> login({
    required String email,
    required String password,
  });

  Future<Result<AuthModel, Object>> verifyAccount({
    required String email,
    required String otp,
  });

  Future<Result<AuthModel, Object>> verifyOtp({
    required String email,
    required String otp,
    required OtpPurpose purpose,
  });

  Future<Result<Null, Object>> resendOtp({
    required String email,
    required OtpPurpose purpose,
  });

  Future<Result<Null, Object>> anonymousUser();
  Future<Result<Null, Object>> logOut();
  Future<Result<Null, Object>> resetPassword({required String newPassword});
  Future<Result<Null, Object>> sendPasswordResetEmail({required String email});
}

@LazySingleton(as: BaseAuthDataSource)
class SubaBaseDataSource implements BaseAuthDataSource {
  final SupabaseClient _supabase;
  final GetStorage _box;
  String? email;

  SubaBaseDataSource({
    required SupabaseClient supabase,
    required GetStorage box,
  }) : _supabase = supabase,
       _box = box;

  /// Sign up with email + password, then user confirms via OTP email.
  @override
  Future<Result<Null, Object>> signUp({
    required String name,
    required String email,
    required String password,
    required String role, // 'pet_owner' or 'service_provider'
  }) async {
    try {
      await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': name, 'role': role},
      );
      this.email = email;
      return Success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  // OTP-only signup (no password) — kept for reference, not used.
  // Login must use email + password, so signup stores a password.
  // @override
  // Future<Result<Null, Object>> signUpWithOtp({
  //   required String name,
  //   required String email,
  //   required String role, // 'pet_owner' or 'service_provider'
  // }) async {
  //   try {
  //     await _supabase.auth.signInWithOtp(
  //       email: email,
  //       shouldCreateUser: true,
  //       data: {
  //         'full_name': name,
  //         'role': role,
  //       },
  //     );
  //     this.email = email;
  //     return Success(null);
  //   } catch (e) {
  //     return Result.error(CatchErrorMessage(error: e).getWriteMessage());
  //   }
  // }

  @override
  Future<Result<Null, Object>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final session = response.session;
      if (session == null) {
        return Error(Exception('No session returned from Supabase.'));
      }

      await AuthHelper.saveLogin(
        token: session.accessToken,
        refreshToken: session.refreshToken!,
        userId: session.user.id,
      );

      return Success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<AuthModel, Object>> verifyAccount({
    required String email,
    required String otp,
  }) async => verifyOtp(email: email, otp: otp, purpose: OtpPurpose.signUp);

  @override
  Future<Result<AuthModel, Object>> verifyOtp({
    required String email,
    required String otp,
    required OtpPurpose purpose,
  }) async {
    try {
      final otpType = switch (purpose) {
        OtpPurpose.signUp => OtpType.signup,
        OtpPurpose.emailChange => OtpType.emailChange,
        OtpPurpose.resetPassword => OtpType.recovery,
      };

      final user = await _supabase.auth.verifyOTP(
        email: email,
        token: otp,
        type: otpType,
      );

      final session = user.session;
      if (session != null) {
        await AuthHelper.saveLogin(
          token: session.accessToken,
          refreshToken: session.refreshToken!,
          userId: user.user!.id,
        );
      }

      if (purpose == OtpPurpose.emailChange) {
        final confirmed =
            (user.user ?? _supabase.auth.currentUser)?.email?.trim() ?? '';
        if (confirmed.toLowerCase() != email.trim().toLowerCase()) {
          return Error(
            'Could not confirm the new email. Please try again with the latest OTP.',
          );
        }
      }

      return Success(
        AuthModel(
          token: session?.accessToken ?? '',
          refreshToken: session?.refreshToken ?? '',
        ),
      );
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<Null, Object>> resendOtp({
    required String email,
    required OtpPurpose purpose,
  }) async {
    try {
      final otpType = switch (purpose) {
        OtpPurpose.signUp => OtpType.signup,
        OtpPurpose.emailChange => OtpType.emailChange,
        OtpPurpose.resetPassword => OtpType.recovery,
      };

      if (purpose == OtpPurpose.resetPassword) {
        await _supabase.auth.resetPasswordForEmail(email.trim());
      } else {
        await _supabase.auth.resend(type: otpType, email: email.trim());
      }

      return Success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<Null, Object>> anonymousUser() async {
    try {
      await _supabase.auth.signInAnonymously();
      await AuthHelper.saveGuestLogin();
      return Success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<Null, Object>> logOut() async {
    try {
      await _supabase.auth.signOut();
      await AuthHelper.logout();
      return Success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<Null, Object>> resetPassword({
    required String newPassword,
  }) async {
    try {
      final response = await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
      if (response.user == null) {
        return Error('Failed to update password. Please try again.');
      }
      return Success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }

  @override
  Future<Result<Null, Object>> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      this.email = email;
      return Success(null);
    } catch (e) {
      return Result.error(CatchErrorMessage(error: e).getWriteMessage());
    }
  }
}

// import 'package:get_storage/get_storage.dart';
// import 'package:injectable/injectable.dart';
// import 'package:multiple_result/multiple_result.dart';
// import 'package:rifq_v2/shared/errors/custome_exception.dart';
// import 'package:rifq_v2/shared/storage_service/auth_helper.dart';
// import 'package:rifq_v2/features/auth/data/models/auth_model.dart';

// import 'package:supabase_flutter/supabase_flutter.dart';

// abstract class BaseAuthDataSource {
//   Future<Result<Null, Object>> signUp({
//     required String name,
//     required String email,
//     required String password,
//   });

//   //----------
//   Future<Result<Null, Object>> login({
//     required String email,
//     required String password,
//   });

//   //---------
//   Future<Result<AuthModel, Object>> verifyAccount({
//     required String email,
//     required String otp,
//   });
//   //---------
//   Future<Result<Null, Object>> anonymousUser();

//   //---------
//   Future<Result<Null, Object>> logOut();

//   //---------
//   Future<Result<Null, Object>> resetPassword({required String newPassword});

//   //---------
//   Future<Result<Null, Object>> sendPasswordResetEmail({required String email});
// }

// @LazySingleton(as: BaseAuthDataSource)
// class SubaBaseDataSource implements BaseAuthDataSource {
//   final SupabaseClient _supabase;
//   final GetStorage _box;
//   String? email;

//   SubaBaseDataSource({
//     required SupabaseClient supabase,
//     required GetStorage box,
//     // this.email,
//   }) : _supabase = supabase,
//        _box = box;

//   @override
//   Future<Result<Null, Object>> signUp({
//     required String name,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final existingProfile = await _supabase
//           .from('profiles')
//           .select('id')
//           .eq('email', email)
//           .maybeSingle();

//       if (existingProfile != null) {
//         return Error('This email is already registered. Please login instead.');
//       }
//       await _supabase.auth.signUp(
//         email: email,
//         password: password,
//         data: {'username': name},
//       );
//       return Success(null);
//     } catch (e) {
//       return Result.error(
//         CatchErrorMessage(error: e).getWriteMessage(),
//       );
//     }
//     // catch (e) {
//     //   return Error(e);
//     // }
//   }

//   //
//   //
//   //

//   @override
//   Future<Result<Null, Object>> login({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       final response = await _supabase.auth.signInWithPassword(
//         email: email,
//         password: password,
//       );
//       final session = response.session;
//       if (session == null) {
//         return Error(Exception('No session returned from Supabase.'));
//       }

//       await AuthHelper.saveLogin(
//         token: session.accessToken,
//         refreshToken: session.refreshToken!,
//         userId: session.user.id,
//       );

//       return Success(null);
//     }catch (e) {
//       return Result.error(
//         CatchErrorMessage(error: e).getWriteMessage(),
//       );
//     }
//     // catch (e) {
//     //   return Error(e);
//     // }
//   }

//   //
//   //
//   //

//   @override
//   Future<Result<AuthModel, Object>> verifyAccount({
//     required String email,
//     required String otp,
//   }) async {
//     try {
//       final user = await _supabase.auth.verifyOTP(
//         email: email,
//         token: otp,
//         type: OtpType.email,
//       );

//       await AuthHelper.saveLogin(
//         token: user.session!.accessToken,
//         refreshToken: user.session!.refreshToken!,
//         userId: user.user!.id,
//       );

//       await _supabase
//           .from('users')
//           .update({'id': user.user!.id})
//           .eq('auth_id', user.user!.id);

//       return Success(
//         AuthModel(
//           token: user.session!.accessToken,
//           refreshToken: user.session!.refreshToken!,
//         ),
//       );
//     } catch (e) {
//       return Result.error(
//         CatchErrorMessage(error: e).getWriteMessage(),
//       );
//     }
//     // catch (e) {
//     //   return Error(e);
//     // }
//   }

//   //
//   //
//   //

//   @override
//   Future<Result<Null, Object>> anonymousUser() async {
//     try {
//       await _supabase.auth.signInAnonymously();

//       await AuthHelper.saveGuestLogin();

//       return Success(null);
//     } catch (e) {
//       return Result.error(
//         CatchErrorMessage(error: e).getWriteMessage(),
//       );
//     }
//     // catch (e) {
//     //   return Error(e);
//     // }
//   }

//   //
//   //
//   //

//   @override
//   Future<Result<Null, Object>> logOut() async {
//     try {
//       await _supabase.auth.signOut();

//       await AuthHelper.logout();

//       return Success(null);
//     } catch (e) {
//       return Result.error(
//         CatchErrorMessage(error: e).getWriteMessage(),
//       );
//     }
//     // catch (e) {
//     //   return Error(e);
//     // }
//   }

//   //
//   //
//   //

//   @override
//   Future<Result<Null, Object>> resetPassword({
//     required String newPassword,
//   }) async {
//     try {
//       final response = await _supabase.auth.updateUser(
//         UserAttributes(email: email!, password: newPassword),
//       );

//       if (response.user == null) {
//         return Error('Failed to update password. Please try again.');
//       }

//       return Success(null);
//     } catch (e) {
//       return Result.error(
//         CatchErrorMessage(error: e).getWriteMessage(),
//       );
//     }
//     // catch (e) {
//     //   return Error(e);
//     // }
//   }

//   //
//   //
//   //

//   @override
//   Future<Result<Null, Object>> sendPasswordResetEmail({
//     required String email,
//   }) async {
//     try {
//       await _supabase.auth.resetPasswordForEmail(email);
//       this.email = email;
//       return Success(null);
//     } catch (e) {
//       return Result.error(
//         CatchErrorMessage(error: e).getWriteMessage(),
//       );
//     }
//     // catch (e) {
//     //   return Error(e);
//     // }
//   }
// }
