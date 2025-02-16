// main.dart
import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:exam_app/features/auth/persentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/injectable.dart';
import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> isUserLoggedIn;

  @override
  void initState() {
    super.initState();
    isUserLoggedIn = _isUserLoggedIn(); 
  }

  Future<bool> _isUserLoggedIn() async {
    final token = await getIt<LocalStorageClient>().getSecuredData('token');
    return token != null;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => FutureBuilder<bool>(
        future: isUserLoggedIn,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: Routes.login,
              onGenerateRoute: generateRoute,
              theme: ThemeData(),
            );
          }

          return BlocProvider<AuthCubit>(
            create: (_) => getIt<AuthCubit>(),
            child: MaterialApp(
              color: Colors.white,
              navigatorKey: getIt<GlobalKey<NavigatorState>>(),
              debugShowCheckedModeBanner: false,
              initialRoute: snapshot.data! ? Routes.profile : Routes.login,
              onGenerateRoute: generateRoute,
              theme: ThemeData(),
            ),
          );
        },
      ),
    );
  }
}
