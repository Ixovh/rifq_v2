// import 'dart:convert';
// import 'dart:io';

// import 'package:supabase_flutter/supabase_flutter.dart';


// class CustomException implements Exception {
//   /// A message describing the format error.
//   final String message;

//   const CustomException({this.message = ""});
//   @override
//   String toString() {
//     return message;
//   }
// }



// class CatchErrorMessage {
//   final Object error;

//   CatchErrorMessage({required this.error});

//   String getWriteMessage() {

//     String? errorMessage;

//     switch (error) {
//       case SocketException _:
//         errorMessage = "No internet connection";
//         break;
//       case PostgrestException error:
//         errorMessage = jsonDecode(error.message)['message'];
//         break;
//       case AuthApiException error:
//         errorMessage = error.message;
//         break;
//       case StorageException error:
//         errorMessage = error.message;
//         break;
//       case CustomException error:
//         errorMessage = error.message;
//         break;
//       case Exception error:
//         errorMessage = error.toString();
//         break;
//       default:
//         errorMessage = error.toString();
//         break;
//     }

//     switch (errorMessage) {
//       case "Cannot coerce the result to a single JSON object":
//         errorMessage = "Empty data update";
//         break;
//     }

//     // switch (errorMessage) {
//     //   case "Cannot coerce the result to a single JSON object":
//     //     errorMessage = "Empty data update";
//     //     break;
//     //   default:
//     //     errorMessage = error.toString();
//     // }
//     return errorMessage ?? "An unexpected error occurred";  }
// }

import 'dart:convert';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class CustomException implements Exception {
  /// A message describing the format error.
  final String message;

  const CustomException({this.message = ""});
  @override
  String toString() {
    return message;
  }
}

class CatchErrorMessage {
  final Object error;

  CatchErrorMessage({required this.error});

  String getWriteMessage() {
    String? errorMessage;

    switch (error) {
      case SocketException _:
        errorMessage = "تأكد من اتصالك بالإنترنت";
        break;
      case PostgrestException error:
        errorMessage = jsonDecode(error.message)['message'];
        break;
      case AuthApiException error:
        errorMessage = _mapAuthError(error);
        break;
      case StorageException error:
        errorMessage = error.message;
        break;
      case CustomException error:
        errorMessage = error.message;
        break;
      case Exception error:
        errorMessage = error.toString();
        break;
      default:
        errorMessage = error.toString();
        break;
    }

    switch (errorMessage) {
      case "Cannot coerce the result to a single JSON object":
        errorMessage = "Empty data update";
        break;
    }

    return errorMessage ?? "حدث خطأ غير متوقع، حاول مرة أخرى";
  }

  String _mapAuthError(AuthApiException error) {
    switch (error.code) {
      case 'invalid_credentials':
        return 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
      case 'email_not_confirmed':
        return 'يرجى تفعيل بريدك الإلكتروني أولاً عبر الرابط المرسل لك';
      case 'user_already_exists':
        return 'هذا البريد مسجل مسبقًا، جرّب تسجيل الدخول';
      case 'weak_password':
        return 'كلمة المرور ضعيفة، استخدم 6 أحرف على الأقل';
      case 'over_email_send_rate_limit':
        return 'الرجاء الانتظار قليلاً قبل إعادة إرسال البريد';
      case 'invalid_email':
        return 'صيغة البريد الإلكتروني غير صحيحة';
      default:
        return error.message;
    }
  }
}