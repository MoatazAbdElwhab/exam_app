// core/app_repository/app_repository.dart
import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AppRepository {
  final InternetConnectionChecker checker;
  bool isOnline = true;
  StreamSubscription<InternetConnectionStatus>? _subscription;

  AppRepository(this.checker) {
    _checkOnline();
  }

  void _checkOnline() {
    _subscription = checker.onStatusChange.listen((status) {
      bool isCheckerConnected = status == InternetConnectionStatus.connected;
      if (isOnline != isCheckerConnected) {
        isOnline = isCheckerConnected;
      }
    });
  }

  void dispose() {
    _subscription?.cancel();
  }
}
