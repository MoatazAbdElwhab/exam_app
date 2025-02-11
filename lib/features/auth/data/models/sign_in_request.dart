import 'package:exam_app/core/app_data/api/api_constants.dart';

class SignInRequest {
  final String email;
  final String password;

  SignInRequest({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        ApiConstants.emailKey: email,
        ApiConstants.passwordKey: password,
      };
}
