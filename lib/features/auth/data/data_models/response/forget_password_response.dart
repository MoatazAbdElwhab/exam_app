class ForgetPasswordResponse {
  final String? message;
  final num? code;
  final String? info;

  ForgetPasswordResponse({
    this.message,
    this.code,
    this.info,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgetPasswordResponse(
      message: json['message'],
      code: json['code'],
      info: json['info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'info': info,
    };
  }
}