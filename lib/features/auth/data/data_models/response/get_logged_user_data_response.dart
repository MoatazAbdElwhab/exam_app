import '../user_dto.dart';

class GetLoggedUserDataResponse {
  GetLoggedUserDataResponse({
    String? message,
    int? code,
    UserDto? user,
  }) {
    _message = message;
    _user = user;
    _code = code;
  }

  GetLoggedUserDataResponse.fromJson(dynamic json) {
    _message = json['message'];
    _code = json['code'];
    _user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
  }
  String? _message;
  int? _code;
  UserDto? _user;

  String? get message => _message;
  int? get code => _code;
  UserDto? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['code'] = _code;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}
