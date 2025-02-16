import 'package:dio/dio.dart';
import 'package:exam_app/core/app_data/api/server_error.dart';
import 'package:exam_app/core/app_data/result.dart';
import 'package:exam_app/core/models/error_model.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() apiCall) async {
  try {
    var result = await apiCall.call();
    return Success(result);
  } on DioException catch (ex) {
    switch (ex.type) {
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
        {
          return Error(NetworkError());
        }
      case DioExceptionType.badResponse:
        {
          var responseCode = ex.response?.statusCode ?? 0;
          var errorModel = ErrorModel.fromJson(ex.response?.data);
          print(errorModel.message);
          if (responseCode >= 400 && responseCode < 500) {
            return Error(ClientError(errorModel));
          }
          if (responseCode >= 500 && responseCode < 600) {
            return Error(ServerError(errorModel));
          }
          return Error(Exception("Something went wrong"));
        }
      default:
        {
          return Error(Exception("Something went wrong"));
        }
    }
  } on Exception catch (ex) {
    return Error(ex);
  }
}
