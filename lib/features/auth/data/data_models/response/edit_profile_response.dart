// features/auth/data/data_models/response/edit_profile_response.dart
import 'package:flutter/foundation.dart';
import '../user_dto.dart';

@immutable
class EditProfileResponse {
  final String? message;
  final num? code;
  final UserDto? user;

  const EditProfileResponse({
    this.message,
    this.code,
    this.user,
  });

  factory EditProfileResponse.fromJson(Map<String, dynamic> json) {
    return EditProfileResponse(
      message: json['message'] as String?,
      code: json['code'] as num?,
      user: json['user'] != null ? UserDto.fromJson(json['user'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'code': code,
      'user': user?.toJson(),
    };
  }

  @override
  String toString() {
    return 'EditProfileResponse(message: $message, code: $code, user: $user)';
  }
}
