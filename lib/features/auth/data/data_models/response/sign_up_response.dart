// features/auth/data/data_models/response/sign_up_response.dart
import 'package:exam_app/features/auth/data/data_models/user_dto.dart';

class SignUpResponse {
  final String? message;
  final String? token;
  final int? code;
  final UserDto? user;

  SignUpResponse({
    this.message,
    this.token,
    this.code,
    this.user,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      message: json['message'] as String?,
      token: json['token'] as String?,
      code: json['code'] as int?,
      user: json['user'] != null ? UserDto.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'token': token,
      'code': code,
      'user': user?.toJson(),
    };
  }
}