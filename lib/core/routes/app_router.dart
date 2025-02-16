// core/routes/app_router.dart
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/features/auth/persentation/cubit/auth_cubit.dart';
import 'package:exam_app/features/auth/persentation/pages/forgetpassword_page.dart';
import 'package:exam_app/features/auth/persentation/pages/login_page.dart';
import 'package:exam_app/features/auth/persentation/pages/pin_code_page.dart';
import 'package:exam_app/features/auth/persentation/pages/reset_password_page.dart';
import 'package:exam_app/features/auth/persentation/pages/signup_page.dart';
import 'package:exam_app/features/nav/navbar_page.dart';
import 'package:exam_app/features/profile/changepassword_page.dart';
import 'package:exam_app/features/profile/profile_page.dart';
import 'package:exam_app/features/result/result_page.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/features/explore/presentation/pages/explore_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../di/injectable.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {

    //login page
    case Routes.login:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: const LoginPage(),
        ),
      );

      //signup page
    case Routes.signup:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt<AuthCubit>(),
          child: const SignupPage(),
        ),
      );

      //forget password page
    case Routes.forgetPassword:
      return MaterialPageRoute(builder: (_) => const ForgetpasswordPage());

      //pin code page
    case Routes.pinCode:
     final args = settings.arguments as Map<String, dynamic>;
  final email = args['email'] ?? ''; // Retrieve email from arguments
      return MaterialPageRoute(builder: (_) =>  PinCodePage(email: email,));

//resetpassword
  case Routes.resetPassword:
  final args = settings.arguments as Map<String, dynamic>;
  final email = args['email'] ?? ''; // Retrieve email from arguments
  final resetCode = args['resetCode'] ?? ''; // Retrieve reset code from arguments

  return MaterialPageRoute(
    builder: (_) => ResetPasswordPage(
      email: email, // Pass the email to the page
      resetCode: resetCode, // Pass the resetCode to the page
    ),
  );
      //profile page
    case Routes.profile:
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt<AuthCubit>()..getLoggedUserInfo(),
          child: const ProfilePage(),
        ),
      );

    case Routes.profileResetPassword:
      return MaterialPageRoute(builder: (_) => const ResetpasswordPage());

      //navbar page
    case Routes.navbar:
      return MaterialPageRoute(builder: (_) => const NavbarPage());

      //explore page
    case Routes.explore:
      return MaterialPageRoute(builder: (_) => const ExplorePage());

      //result page
    case Routes.result:
      return MaterialPageRoute(builder: (_) => const ResultPage());

      //default
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               const Icon(
                  Icons.error,
                  size: 50,
                  color: Colors.red,
                ),
               const SizedBox(height: 10),
                Text(
                  'No route defined for ${settings.name}',
                  style:const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
