// core/routes/app_router.dart
import 'package:exam_app/core/routes/routes.dart';
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
import 'package:exam_app/features/result/presentation/pages/result_page.dart';


Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.login:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const LoginPage(),
      );
    case Routes.signup:
      return MaterialPageRoute(
        settings: settings,
        builder: (con) => const SignupPage(),
      );
    case Routes.forgetPassword:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const ForgetpasswordPage());
    case Routes.pinCode:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const PinCodePage());
    case Routes.resetPassword:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const ResetPasswordPage());
    case Routes.profile:
      return MaterialPageRoute(
        settings: settings,
        builder: (con) => const ProfilePage(),
      );
    case Routes.profileResetPassword:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const ResetpasswordPage());
    case Routes.navbar:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const NavbarPage());
    case Routes.explore:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const ExplorePage());
    case Routes.result:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const ResultPage());
    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
