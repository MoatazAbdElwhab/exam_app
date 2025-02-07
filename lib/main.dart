// main.dart
import 'package:exam_app/features/auth/presentation/pages/login_page.dart';
import 'package:exam_app/features/nav/navbar_page.dart';
import 'package:exam_app/features/profile/presentation/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: LoginPage(),
        home: NavbarPage(),
      ),
    );
  }
}
