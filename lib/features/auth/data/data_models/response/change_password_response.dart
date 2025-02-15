// features/auth/data/data_models/response/change_password_response.dart
class ChangePasswordResponse {
  final String? message;
  final num? code;
  final String? token;

  ChangePasswordResponse({
    this.message,
    this.code,
    this.token,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      message: json['message'],
      code: json['code'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'token': token,
    };
  }
}