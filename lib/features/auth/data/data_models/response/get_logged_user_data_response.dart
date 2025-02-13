import '../user_dto.dart';

class GetLoggedUserDataResponse {
  final String? message;
  final num? code;
  final UserDto? user;

  GetLoggedUserDataResponse({
    this.message,
    this.code,
    this.user,
  });

  factory GetLoggedUserDataResponse.fromJson(Map<String, dynamic> json) {
    return GetLoggedUserDataResponse(
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
