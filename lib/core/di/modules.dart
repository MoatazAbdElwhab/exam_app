// core/di/modules.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class GetItRegisterModule {
  @lazySingleton
  InternetConnectionChecker get internetConnectionChecker =>
      InternetConnectionChecker.createInstance();

  @lazySingleton
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences async {
    try {
      return await SharedPreferences.getInstance();
    } catch (e) {
      throw Exception("Failed to initialize SharedPreferences: \$e");
    }
  }

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
