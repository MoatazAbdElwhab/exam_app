import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:exam_app/core/routes/navigator_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/injectable.dart';
import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await _isUserLoggedIn().then((value) => isUserLoggedIn = value ?? false);
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
      builder: (_, __) => BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: MaterialApp(
          color: Colors.white,
          navigatorObservers: [getIt<AppNavigatorObserver>()],
          navigatorKey: getIt<GlobalKey<NavigatorState>>(),
          debugShowCheckedModeBanner: false,
          initialRoute: isUserLoggedIn! ? Routes.profile : Routes.login,
          onGenerateRoute: generateRoute,
          theme: ThemeData(),
        ),
      ),
    );
  }
}

Future<bool?> _isUserLoggedIn() async {
  return await getIt<LocalStorageClient>().getRememberMe();
}
