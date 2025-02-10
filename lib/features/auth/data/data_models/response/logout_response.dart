
class LogoutResponse {
  LogoutResponse({
    String? message,
    num? code,}){
    _message = message;
    _code = code;
  }

  LogoutResponse.fromJson(dynamic json) {
    _message = json['message'];
    _code = json['code'];
  }
  String? _message;
  num? _code;

  LogoutResponse copyWith({  String? message,
    num? code,
  }) => LogoutResponse(message: message ?? _message,
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