import 'package:exam_app/core/models/error_model.dart';

class ServerError implements Exception {
  ErrorModel? errorModel;
  ServerError(this.errorModel);
}

class NetworkError implements Exception {
  NetworkError();
}

class ClientError implements Exception {
  ErrorModel? errorModel;
  ClientError(this.errorModel);
}

class ServerSideError implements Exception {
  ErrorModel? errorModel;
  ServerSideError(this.errorModel);
}
