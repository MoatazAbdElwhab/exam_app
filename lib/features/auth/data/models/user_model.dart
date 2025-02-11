import 'package:exam_app/core/app_data/api/api_constants.dart';

class UserModel {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String role;
  final bool isVerified;
  final String id;
  final DateTime createdAt;

  const UserModel({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.role,
    required this.isVerified,
    required this.id,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json[ApiConstants.usernameKey] as String,
        firstName: json[ApiConstants.firstNameKey] as String,
        lastName: json[ApiConstants.lastNameKey] as String,
        email: json[ApiConstants.emailKey] as String,
        phone: json[ApiConstants.phoneKey] as String,
        role: json[ApiConstants.roleKey] as String,
        isVerified: json[ApiConstants.isVerifiedKey] as bool,
        id: json[ApiConstants.idKey] as String,
        createdAt: DateTime.parse(json[ApiConstants.createdAtKey] as String),
      );

  Map<String, dynamic> toJson() => {
        ApiConstants.usernameKey: username,
        ApiConstants.firstNameKey: firstName,
        ApiConstants.lastNameKey: lastName,
        ApiConstants.emailKey: email,
        ApiConstants.phoneKey: phone,
        ApiConstants.roleKey: role,
        ApiConstants.isVerifiedKey: isVerified,
        ApiConstants.idKey: id,
        ApiConstants.createdAtKey: createdAt.toIso8601String(),
      };

  UserModel copyWith({
    String? username,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? role,
    bool? isVerified,
    String? id,
    DateTime? createdAt,
  }) {
    return UserModel(
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
