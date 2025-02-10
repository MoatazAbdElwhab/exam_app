
class ForgetPasswordResponse {
  LogoutResponse({
    String? message,
    String? info,
    num? code,}){
    _message = message;
    _code = code;
  }

  ForgetPasswordResponse.fromJson(dynamic json) {
    _message = json['message'];
    _info = json['info'];
    _code = json['code'];
  }
  String? _message;
  String? _info;
  num? _code;

  ForgetPasswordResponse copyWith({  String? message,
    num? code,
    String? info,
  }) => LogoutResponse(
    message: message ?? _message,
    info: info ?? _info,
    code: code ?? _code,
  );

  String? get message => _message;
  num? get code => _code;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['code'] = _code;
    return map;
  }
}