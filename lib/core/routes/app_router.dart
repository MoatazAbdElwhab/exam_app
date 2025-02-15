// core/routes/app_router.dart
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/features/auth/persentation/cubit/auth_cubit.dart';
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
      return MaterialPageRoute(builder: (_) => const PinCodePage());

      //reset password page
    case Routes.resetPassword:
      return MaterialPageRoute(builder: (_) => const ResetPasswordPage());

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
                Icon(
                  Icons.error,
                  size: 50,
                  color: Colors.red,
                ),
                SizedBox(height: 10),
                Text(
                  'No route defined for ${settings.name}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      );
  }
}
