import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class GetItRegisterModule {
  @singleton
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  /// internet
  @singleton
  InternetConnectionChecker get checker =>
      InternetConnectionChecker.createInstance();

  /// local
  @preResolve
  @singleton
  Future<SharedPreferences> get sharedPreferences async =>
      SharedPreferences.getInstance();

  @singleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
