// main.dart
import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/injectable.dart';
import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await _isUserLoggedIn().then((value) => isUserLoggedIn = value);
  runApp(const MyApp());
}

bool? isUserLoggedIn;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        color: Colors.white,
        navigatorKey: getIt<GlobalKey<NavigatorState>>(),
        debugShowCheckedModeBanner: false,
        initialRoute: isUserLoggedIn! ? Routes.profile : Routes.login,
        onGenerateRoute: generateRoute,
        theme: ThemeData(),
      ),
    );
  }
}

Future<bool> _isUserLoggedIn() async {
  final token = await getIt<LocalStorageClient>().getSecuredData('token');
  return token != null;
}