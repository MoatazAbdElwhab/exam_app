// main.dart
import 'package:exam_app/core/services/local_storage.dart';
import 'package:exam_app/features/auth/presentation/pages/login_page.dart';
import 'package:exam_app/features/nav/navbar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalStorage.init(); // Ensure SharedPreferences is initialized before running the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkRememberMe() async {
    return AppLocalStorage.getCachedData(AppLocalStorage.rememberMeKey) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => FutureBuilder<bool>(
        future: checkRememberMe(), // Load stored rememberMe state
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(child: CircularProgressIndicator()), // Loading screen while fetching data
              ),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: snapshot.data == true ? NavbarPage() : LoginPage(),
            );
          }
        },
      ),
    );
  }
}
