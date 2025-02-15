// features/auth/data/data_models/response/sign_in_response.dart
import '../user_dto.dart';

class SignInResponse {
  final String? message;
  final num? code;
  final String? token;
  final UserDto? user;

  SignInResponse({
    this.message,
    this.code,
    this.token,
    this.user,
  });

  factory SignInResponse.fromJson(Map<String, dynamic> json) {
    return SignInResponse(
      message: json['message'],
      code: json['code'],
      token: json['token'],
      user: json['user'] != null ? UserDto.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'token': token,
      'user': user?.toJson(),
    };
  }
}