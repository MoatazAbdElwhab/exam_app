class ResetPasswordResponse {
  final String? message;
  final num? code;
  final String? token;

  ResetPasswordResponse({
    this.message,
    this.code,
    this.token,
  });

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ResetPasswordResponse(
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
