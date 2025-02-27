// features/result/data/data_sources/result_remote_data_source.dart
/* // features/result/data/data_sources/result_remote_data_source.dart
import 'dart:developer' as dev;
import 'package:either_dart/either.dart';
import 'package:exam_app/core/app_data/api/api_client.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';
import 'package:exam_app/features/result/data/data_models/history_response_model.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/data/data_models/result_response_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResultRemoteDataSource {
  final ApiClient _apiClient;

  ResultRemoteDataSource(this._apiClient);


//------------------------------------------------------fetchQuestions------------------------------------------------------
  Future<Either<ApiException, List<QuestionRequestModel>>> fetchQuestions() async {
    try {
      final response = await _apiClient.get('/questions', requiresToken: true);
      dev.log('Questions Response: $response');
      
      if (response != null) {
        if (response['questions'] != null && response['questions'] is List) {
          final List<dynamic> data = response['questions'] as List<dynamic>;
          final questions = data
              .map((json) => QuestionRequestModel.fromJson(json as Map<String, dynamic>))
              .toList();
          return Right(questions);
        } else if (response['data'] != null && response['data'] is List) {
          final List<dynamic> data = response['data'] as List<dynamic>;
          final questions = data
              .map((json) => QuestionRequestModel.fromJson(json as Map<String, dynamic>))
              .toList();
          return Right(questions);
        }
      }
      dev.log('Invalid Questions Response Format: $response');
      return Left(ApiException(message: 'Invalid response format'));
    } catch (e, stackTrace) {
      dev.log('Error in fetchQuestions: $e\n$stackTrace');
      return Left(ApiException(message: e.toString()));
    }
  }


//------------------------------------------------------submitAnswers------------------------------------------------------
  Future<Either<ApiException, ResultResponseModel>> submitAnswers(
      QuestionRequestModel request) async {
    try {
      final response = await _apiClient.post(
        '/questions/check',
        data: request.toJson(),
        requiresToken: true,
      );
      dev.log('Submit Answer Response: $response');
      
      if (response != null && response is Map<String, dynamic>) {
        return Right(ResultResponseModel.fromJson(response));
      }
      dev.log('Invalid Submit Answer Response Format: $response');
      return Left(ApiException(message: 'Invalid response format'));
    } catch (e, stackTrace) {
      dev.log('Error in submitAnswers: $e\n$stackTrace');
      return Left(ApiException(message: e.toString()));
    }
  }


//------------------------------------------------------fetchHistory------------------------------------------------------
  Future<Either<ApiException, HistoryResponseModel>> fetchHistory() async {
    try {
      final response = await _apiClient.get('/questions/history', requiresToken: true);
      dev.log('History Response: $response');
      
      if (response != null && response is Map<String, dynamic>) {
        return Right(HistoryResponseModel.fromJson(response));
      }
      dev.log('Invalid History Response Format: $response');
      return Left(ApiException(message: 'Invalid response format'));
    } catch (e, stackTrace) {
      dev.log('Error in fetchHistory: $e\n$stackTrace');
      return Left(ApiException(message: e.toString()));
    }
  }
}
 */
