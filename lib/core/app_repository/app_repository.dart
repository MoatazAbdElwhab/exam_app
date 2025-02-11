//  class AppRepository {
//    void _handleInternetConnection() {
//      _subscription = _connectionChecker.onStatusChange.listen((status) async {
//        bool isConnected = status == InternetConnectionStatus.connected;
//        if (isConnected != state.isOnline) {
//          emit(state.copyWith(
//            isOnline: isConnected,
//            isInitial: false,
//          ));
//        }
//      });
//    }
// }
