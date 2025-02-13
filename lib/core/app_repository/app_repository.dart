import 'package:internet_connection_checker/internet_connection_checker.dart';

class AppRepository {
  final InternetConnectionChecker checker;
  AppRepository(this.checker);
   bool get isOnline {
       bool isConnected = true;
       checker.onStatusChange.listen((status) async {
         isConnected = status ==
             InternetConnectionStatus.connected;
       });
       return isConnected;
   }
}
