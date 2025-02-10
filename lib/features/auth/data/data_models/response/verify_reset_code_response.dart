class VerifyResetCodeResponse {
  VerifyResetCodeResponse({
    String? message,
    String? status,
    num? code,
  }) {
    _message = message;
    _code = code;
    _status = status;
  }

  VerifyResetCodeResponse.fromJson(dynamic json) {
    _message = json['message'];
    _code = json['code'];
    _status = json['status'];
  }
  String? _message;
  String? _status;
  num? _code;

  VerifyResetCodeResponse copyWith({
    String? message,
    String? status,
    num? code,
  }) =>
      VerifyResetCodeResponse(
        message: message ?? _message,
        status: status ?? _status,
        code: code ?? _code,
      );

  String? get message => _message;
  String? get status => _status;
  num? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['status'] = _status;
    map['code'] = _code;
    return map;
  }
}
