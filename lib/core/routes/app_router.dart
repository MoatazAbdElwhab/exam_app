// core/routes/app_router.dart
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/features/result/presentation/pages/result_page.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/features/auth/presentation/pages/login_page.dart';
import 'package:exam_app/features/auth/presentation/pages/signup_page.dart';
import 'package:exam_app/features/auth/presentation/pages/forgetpassword_page.dart';
import 'package:exam_app/features/auth/presentation/pages/pin_code_page.dart';
import 'package:exam_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:exam_app/features/profile/presentation/pages/profile_page.dart';
import 'package:exam_app/features/profile/presentation/pages/resetpassword_page.dart';
import 'package:exam_app/features/nav/navbar_page.dart';
import 'package:exam_app/features/explore/presentation/pages/explore_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.login:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    case Routes.signup:
      return MaterialPageRoute(builder: (_) => const SignupPage());
    case Routes.forgetPassword:
      return MaterialPageRoute(builder: (_) => const ForgetpasswordPage());
    case Routes.pinCode:
      return MaterialPageRoute(builder: (_) => const PinCodePage());
    case Routes.resetPassword:
      return MaterialPageRoute(builder: (_) => const ResetPasswordPage());
    case Routes.profile:
      return MaterialPageRoute(builder: (_) => const ProfilePage());
    case Routes.profileResetPassword:
      return MaterialPageRoute(builder: (_) => const ResetpasswordPage());
    case Routes.navbar:
      return MaterialPageRoute(builder: (_) => const NavbarPage());
    case Routes.explore:
      return MaterialPageRoute(builder: (_) => const ExplorePage());
    case Routes.result:
      return MaterialPageRoute(builder: (_) =>  ResultPage());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
