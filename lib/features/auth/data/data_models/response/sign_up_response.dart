import 'package:exam_app/features/auth/data/data_models/user_dto.dart';

class SignUpResponse {
  SignUpResponse({
    String? message,
    String? token,
    int? code,
    UserDto? user,
  }) {
    _message = message;
    _code = code;
    _token = token;
    _user = user;
  }

  SignUpResponse.fromJson(dynamic json) {
    _message = json['message'];
    _token = json['token'];
    _user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
    _code = json['code'];
  }
  String? _message;
  String? _token;
  UserDto? _user;
  int? _code;
// SignUpResponse copyWith({  String? message,
//   String? token,
//   UserDto? user,
// }) => SignUpResponse(  message: message ?? _message,
//   token: token ?? _token,
//   user: user ?? _user,
// );

  String? get message => _message;
  String? get token => _token;
  UserDto? get user => _user;
  int? get code => _code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['token'] = _token;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    map['code'] = _code;

    return map;
  }
}
