import 'package:exam_app/core/app_data/api/api_constants.dart';

class ErrorModel {
  final String? message;
  final int? code;

  const ErrorModel({
    this.message,
    this.code,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> json) => ErrorModel(
        message: json[ApiConstants.messageKey] as String?,
        code: json[ApiConstants.codeKey] as int?,
      );
}
