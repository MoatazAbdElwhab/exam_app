class DeleteAccountResponse {
  final String? message;
  final num? code;

  DeleteAccountResponse({
    this.message,
    this.code,
  });

  factory DeleteAccountResponse.fromJson(Map<String, dynamic> json) {
    return DeleteAccountResponse(
      message: json['message'],
      code: json['code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
    };
  }
}
