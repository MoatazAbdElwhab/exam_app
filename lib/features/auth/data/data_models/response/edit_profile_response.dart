import '../edit_profile_user_dto.dart';
import '../user_dto.dart';

class EditProfileResponse {
  EditProfileResponse({
    String? message,
    int? code,
    EditProfileUserDto? editProfileUserDto,
  }) {
    _message = message;
    _editProfileUserDto = editProfileUserDto;
    _code = code;
  }

  EditProfileResponse.fromJson(dynamic json) {
    _message = json['message'];
    _code = json['code'];
    _editProfileUserDto =
        json['user'] != null ? EditProfileUserDto.fromJson(json['user']) : null;
  }
  String? _message;
  int? _code;
  EditProfileUserDto? _editProfileUserDto;

  String? get message => _message;
  int? get code => _code;
  EditProfileUserDto? get user => _editProfileUserDto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['code'] = _code;
    if (_editProfileUserDto != null) {
      map['user'] = _editProfileUserDto?.toJson();
    }
    return map;
  }
}
