import 'package:exam_app/core/app_bloc_observer.dart';
import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:exam_app/core/routes/navigator_observer.dart';
import 'package:exam_app/core/widgets/dialog_utils.dart';
import 'package:exam_app/features/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'core/di/injectable.dart';
import 'core/logger/app_logger.dart';
import 'core/routes/app_router.dart';
import 'core/routes/routes.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';

int? buildOutBuild;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  runApp(const SplashScreen());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (con, _) => BlocProvider.value(
        value: getIt<AuthCubit>(),
        child: MaterialApp(
          color: Colors.white,
          navigatorObservers: [getIt<AppNavigatorObserver>()],
          navigatorKey: getIt<GlobalKey<NavigatorState>>(),
          debugShowCheckedModeBanner: false,
          initialRoute:
              isUserLoggedInAutomatically ? Routes.navbar : Routes.login,
          onGenerateRoute: generateRoute,
          theme: ThemeData(),
        ),
      ),
    );
  }
}
