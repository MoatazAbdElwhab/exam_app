
class ChangePasswordResponse {
  ChangePasswordResponse({
      String? message, 
      num? code, 
      String? token,}){
    _message = message;
    _code = code;
    _token = token;
}

  ChangePasswordResponse.fromJson(dynamic json) {
    _message = json['message'];
    _code = json['code'];
    _token = json['token'];
  }
  String? _message;
  num? _code;
  String? _token;

ChangePasswordResponse copyWith({  String? message,
  num? code,
  String? token,
}) => ChangePasswordResponse(  message: message ?? _message,
  code: code ?? _code,
  token: token ?? _token,
);

  String? get message => _message;
  num? get code => _code;
  String? get token => _token;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['code'] = _code;
    map['token'] = _token;
    return map;
  }
}