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
        errorMessage = "No internet connection";
        break;
      case PostgrestException error:
        errorMessage = jsonDecode(error.message)['message'];
        break;
      case AuthApiException error:
        errorMessage = error.message;
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

    // switch (errorMessage) {
    //   case "Cannot coerce the result to a single JSON object":
    //     errorMessage = "Empty data update";
    //     break;
    //   default:
    //     errorMessage = error.toString();
    // }
    return errorMessage ?? "An unexpected error occurred";  }
}