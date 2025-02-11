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
      message: json['message'] as String,
      token: json['token'] as String,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        'token': token,
        'user': user.toJson(),
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
