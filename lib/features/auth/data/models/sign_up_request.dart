import 'package:exam_app/core/app_data/api/api_constants.dart';

class SignUpRequest {
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;

  SignUpRequest({
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        ApiConstants.usernameKey: username,
        ApiConstants.firstNameKey: firstName,
        ApiConstants.lastNameKey: lastName,
        ApiConstants.emailKey: email,
        ApiConstants.passwordKey: password,
        ApiConstants.rePasswordKey: rePassword,
        ApiConstants.phoneKey: phone,
      };
}
