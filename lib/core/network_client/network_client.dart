// import 'package:injectable/injectable.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// @singleton
// class NetworkClient {
//   final InternetConnectionChecker checker;
//   NetworkClient(this.checker);

//   final _subscription = checker.onStatusChange.listen((status) async {
//     bool isConnected = status == InternetConnectionStatus.connected;
//     if (isConnected != state.isOnline) {
//       emit(state.copyWith(
//         isOnline: isConnected,
//         isInitial: false,
//       ));
//     }
//   });
// }
