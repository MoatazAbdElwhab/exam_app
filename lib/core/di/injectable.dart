import 'package:exam_app/core/di/injectable.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()

Future<void> configureDependencies() async {
 getIt.init();
 await Future.delayed(const Duration(seconds: 3));

}
