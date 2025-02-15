// features/auth/data/data_models/response/delete_account_response.dart
import 'package:flutter/foundation.dart';

@immutable
class DeleteAccountResponse {
  final String? message;
  final num? code;

  const DeleteAccountResponse({
    this.message,
    this.code,
  });

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) {
    return DeleteAccountResponse(
      message: json['message'] as String?,
      code: json['code'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
    };
  }

  @override
  String toString() => 'DeleteAccountResponse(message: $message, code: $code)';
}
