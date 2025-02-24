class VerifyResetCodeResponse {
  final String? message;
  final num? code;
  final String? status;

  VerifyResetCodeResponse({
    this.message,
    this.code,
    this.status,
  });

  factory VerifyResetCodeResponse.fromJson(Map<String, dynamic> json) {
    return VerifyResetCodeResponse(
      message: json['message'],
      code: json['code'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'status': status,
    };
  }
}
