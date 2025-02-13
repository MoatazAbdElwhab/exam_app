import 'package:internet_connection_checker/internet_connection_checker.dart';

class AppRepository {
  final InternetConnectionChecker checker;
  bool isOnline = true;

  AppRepository(this.checker) {
    _checkOnline();
  }
  bool _checkOnline() {
    checker.onStatusChange.listen((
        status)  {
      bool isCheckerConnected =  status == InternetConnectionStatus.connected?
      true : false;

      if (isOnline != isCheckerConnected){
        isOnline = isCheckerConnected;
      }
    });
    return isOnline;
  }
}
