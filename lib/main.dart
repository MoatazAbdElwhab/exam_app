// main.dart
import 'package:exam_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/injectable.dart';
import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
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
      builder: (_, __) =>  MaterialApp(
        navigatorKey: getIt<GlobalKey<NavigatorState>>(),
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.login,
        onGenerateRoute: generateRoute,
        theme: ThemeData(

        ),
      ),

    );
  }
}
