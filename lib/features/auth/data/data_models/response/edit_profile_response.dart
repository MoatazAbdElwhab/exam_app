import '../user_dto.dart';

class EditProfileResponse {
  final String? message;
  final num? code;
  final UserDto? user;

  EditProfileResponse({
    this.message,
    this.code,
    this.user,
  });

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) {
    return EditProfileResponse(
      message: json['message'],
      code: json['code'],
      user: json['user'] != null ? UserDto.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'user': user?.toJson(),
    };
  }
}