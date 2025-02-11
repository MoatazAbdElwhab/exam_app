import 'package:exam_app/core/app_data/api/api_constants.dart';
import 'package:exam_app/features/auth/data/models/user_model.dart';

class AuthResponse {
  final String message;
  final String token;
  final UserModel user;

  const AuthResponse({
    required this.message,
    required this.token,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      message: json[ApiConstants.messageKey] as String,
      token: json[ApiConstants.tokenKey] as String,
      user: UserModel.fromJson(
          json[ApiConstants.userKey] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        ApiConstants.messageKey: message,
        ApiConstants.tokenKey: token,
        ApiConstants.userKey: user.toJson(),
      };

  AuthResponse copyWith({
    String? message,
    String? token,
    UserModel? user,
  }) {
    return AuthResponse(
      message: message ?? this.message,
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }
}
