import 'package:equatable/equatable.dart';

class UserDto extends Equatable {
  final String? username;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? role;
  final bool? isVerified;
  final String? id;
  final String? createdAt;
  final String? passwordChangedAt;
  final String? profilePic;

  const UserDto(
      {this.username,
      this.firstName,
      this.lastName,
      this.email,
      this.phone,
      this.role,
      this.isVerified,
      this.id,
      this.createdAt,
      this.passwordChangedAt,
      this.profilePic});

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
      isVerified: json['isVerified'],
      id: json['_id'],
      createdAt: json['createdAt'],
      passwordChangedAt: json['passwordChangedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'role': role,
      'isVerified': isVerified,
      '_id': id,
      'createdAt': createdAt,
      'passwordChangedAt': passwordChangedAt,
    };
  }

  Map<String, String> toEditProfileMap() {
    return {
      'username': username??'',
      'firstName': firstName??'',
      'lastName': lastName??'',
      'email': email??'',
      'phone': phone??'',
    };
  }

  UserDto copyWith(
      {String? username,
      String? firstName,
      String? lastName,
      String? email,
      String? phone,
      String? role,
      bool? isVerified,
      String? id,
      String? createdAt,
      String? passwordChangedAt,
      String? profilePic}) {
    return UserDto(
      username: username ?? this.username,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isVerified: isVerified ?? this.isVerified,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      passwordChangedAt: passwordChangedAt ?? this.passwordChangedAt,
      profilePic: profilePic ?? this.profilePic,
    );
  }

  @override
  List<Object?> get props => [
        username,
        firstName,
        lastName,
        email,
        passwordChangedAt,
        phone,
        role,
        isVerified,
        createdAt,
        id,
        profilePic
      ];
}
