
class DeleteAccountResponse {
  DeleteAccountResponse({
    String? message,
    num? code,}){
    _message = message;
    _code = code;
  }

  DeleteAccountResponse.fromJson(dynamic json) {
    _message = json['message'];
    _code = json['code'];
  }
  String? _message;
  num? _code;

  DeleteAccountResponse copyWith({  String? message,
    num? code,
    String? token,
  }) => DeleteAccountResponse(message: message ?? _message,
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