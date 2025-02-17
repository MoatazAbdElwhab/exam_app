// main.dart
import 'package:exam_app/core/resources/theming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/di/injectable.dart';
import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  runApp(BlocProvider(
    create: (context) => getIt.get<AuthCubit>(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        // initialRoute: Routes.login,
        initialRoute: Routes.navbar,
        onGenerateRoute: generateRoute,
        //theme: ThemeData(),
        theme: ThemeManager.lightTheme,
      ),
    );
  }
}
