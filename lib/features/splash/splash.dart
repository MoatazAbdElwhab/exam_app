import 'package:exam_app/core/di/injectable.dart';
import 'package:exam_app/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../core/app_data/local_storage/local_storage_client.dart';
import '../../core/logger/app_logger.dart';
import '../../core/widgets/dialog_utils.dart';
import '../../main.dart';
import 'package:lottie/lottie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/services.dart';

late bool isOnline;
late bool isUserLoggedInAutomatically;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  late AnimationController _pageController;
  late Animation<Offset> _pageSlideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeApp();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2700),
      vsync: this,
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    _pageController = AnimationController(
      duration: const Duration(milliseconds: 2700),
      vsync: this,
    );
    _pageSlideAnimation = Tween<Offset>(
      begin: const Offset(0.3, -0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _pageController,
        curve: const Interval(0.0, 0.7, curve: Curves.bounceInOut),
      ),
    );
    _pageController.forward();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SlideTransition(
          position: _pageSlideAnimation,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Lottie.asset(
                  'assets/images/lotties/Animation - 1740399987519 (1).json'),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.15,
                child: FadeTransition(
                  opacity: _fadeInAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Color(0xFF3366FF), Color(0xFF00CCFF)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds),
                        child: AnimatedTextKit(
                          animatedTexts: [
                            WavyAnimatedText(
                              'MSL EXAM APP',
                              textStyle: const TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                              speed: const Duration(milliseconds: 200),
                            ),
                          ],
                          isRepeatingAnimation: false,
                          onTap: () {
                            HapticFeedback.mediumImpact();
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            'Your Path to Success',
                            textStyle: const TextStyle(
                              fontSize: 18,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                            speed: const Duration(milliseconds: 100),
                          ),
                        ],
                        totalRepeatCount: 1,
                        displayFullTextOnTap: true,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> _initializeApp() async {
  try {
    await Future.wait([
      configureDependencies().then(
        (_) => isUserLoggedInAutomatically =
            getIt<LocalStorageClient>().getRememberMe() ?? false,
      ),
      _initializeConnection().then((_) => getIt<ExploreCubit>().getSubjects()),
    ]).then((_) {
      runApp(const MyApp());
    });
  } catch (e) {
    Log.e('Error in splash screen futures: ${e.toString()}');
  }
}

Future<void> _initializeConnection<T>() async {
  final checker = getIt<InternetConnectionChecker>();
  bool isConnected = await checker.hasConnection;
  Log.i('isOnline: $isConnected');
  checker.onStatusChange.listen(
    (status) {
      Log.i('status changed to $status');
      isConnected = (status == InternetConnectionStatus.connected);
      if (getIt<GlobalKey<NavigatorState>>().currentContext != null) {
        getIt<DialogUtils>().showSnackBar(
            textColor: isConnected ? Colors.green : Colors.red,
            message: isConnected
                ? 'Internet connection restored !'
                : 'You are offline',
            context: getIt<GlobalKey<NavigatorState>>().currentContext!);
      }
      isConnected = (status == InternetConnectionStatus.connected);
      Log.i('internet status changed to $status');
    },
  );
  isOnline = isConnected;
}
