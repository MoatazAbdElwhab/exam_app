// main.dart
import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:exam_app/core/routes/navigator_observer.dart';
import 'package:exam_app/core/widgets/dialog_utils.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/di/injectable.dart';
import 'core/logger/app_logger.dart';
import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

late final bool isUserLoggedIn;
late bool isOnline;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  isUserLoggedIn = await _isUserLoggedIn() ?? false;
  isOnline = await _initializeConnection();
  runApp(const MyApp());
}

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
      builder: (_, __) => MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => getIt<AuthCubit>(),
          ),

          //result
          BlocProvider(create: (context) => getIt<ResultCubit>()..fetchQuestions()),
        ],
       // create: (context) => getIt<AuthCubit>(),
        child: MaterialApp(
          color: Colors.white,
          navigatorObservers: [getIt<AppNavigatorObserver>()],
          navigatorKey: getIt<GlobalKey<NavigatorState>>(),
          debugShowCheckedModeBanner: false,
          initialRoute: isUserLoggedIn ? Routes.navbar : Routes.login,
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

Future<bool> _initializeConnection() async {
  final checker = getIt<InternetConnectionChecker>();
  await checker.hasConnection.then((val) {
    isOnline = val;
    Log.i('isOnline: $isOnline');
    checker.onStatusChange.listen(
      (status) {
        bool connected = (status == InternetConnectionStatus.connected);
        if (getIt<GlobalKey<NavigatorState>>().currentContext != null) {
          getIt<DialogUtils>().showSnackBar(
              textColor: connected ? Colors.green : Colors.red,
              message: connected
                  ? 'Internet connection restored !'
                  : 'You are offline',
              context: getIt<GlobalKey<NavigatorState>>().currentContext!);
        }
        isOnline = (status == InternetConnectionStatus.connected);
        Log.i('internet status changed to $status');
      },
    );
  });
  return isOnline;
}
