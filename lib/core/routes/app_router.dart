import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/features/explore/presentation/pages/exams_page.dart';
import 'package:exam_app/features/explore/presentation/pages/start_exam_page.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/features/auth/presentation/pages/login_page.dart';
import 'package:exam_app/features/auth/presentation/pages/signup_page.dart';
import 'package:exam_app/features/auth/presentation/pages/forgetpassword_page.dart';
import 'package:exam_app/features/auth/presentation/pages/pin_code_page.dart';
import 'package:exam_app/features/auth/presentation/pages/reset_password_page.dart';
import 'package:exam_app/features/profile/presentation/pages/resetpassword_page.dart';
import 'package:exam_app/features/nav/page/navbar_page.dart';
import 'package:exam_app/features/explore/presentation/pages/explore_page.dart';
import 'package:exam_app/features/result/presentation/pages/result_page.dart';
import '../../features/splash/splash.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.login:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const LoginPage(),
      );
    case Routes.splash:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const SplashScreen(),
      );
    case Routes.signup:
      return MaterialPageRoute(
        settings: settings,
        builder: (con) => const SignupPage(),
      );
    case Routes.forgetPassword:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ForgetpasswordPage(),
      );
    case Routes.pinCode:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const PinCodePage(),
      );
    case Routes.resetPassword:
      return MaterialPageRoute(
          settings: settings, builder: (_) => const ResetPasswordPage());
    case Routes.profileResetPassword:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ResetpasswordPage(),
      );
    case Routes.navbar:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const NavbarPage(),
      );
    case Routes.explore:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ExplorePage(),
      );
    case Routes.result:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ResultPage(),
      );
    case Routes.exams:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const ExamsPage(),
      );
    case Routes.startExam:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const StartExamPage(),
      );
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
