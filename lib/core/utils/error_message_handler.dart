import 'package:exam_app/core/app_data/api/server_error.dart';
import 'package:flutter/material.dart';

String handleErrorMessage(Exception? ex, [BuildContext? context]) {
  String? message = "";
  switch (ex) {
    case ServerError():
      {
        message = ex.errorModel?.message;
      }
    case ClientError():
      {
        message = ex.errorModel?.message;
      }
    case NetworkError():
      {
        message = "NetworkError";
      }
    default:
      {
        message = "Something went wrong";
      }
  }
  return message!;
}
