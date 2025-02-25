// features/result/data/data_sources/result_remote_data_source.dart
import 'package:either_dart/either.dart';
import 'package:exam_app/core/app_data/api/api_client.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';
import 'package:exam_app/core/logger/app_logger.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/data/data_models/result_response_model.dart';
import 'package:injectable/injectable.dart';

abstract class ResultRemoteDataSource {
  Future<Either<ApiException, List<QuestionRequestModel>>> fetchQuestions();
  Future<Either<ApiException, ResultResponseModel>> submitAnswers(
      QuestionRequestModel request);
}

@Injectable(as: ResultRemoteDataSource)
class ResultRemoteDataSourceImpl implements ResultRemoteDataSource {
  final ApiClient _apiClient;

  ResultRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Either<ApiException, List<QuestionRequestModel>>>
      fetchQuestions() async {
    try {
      Log.d('Fetching questions from remote data source...');
      final response = await _apiClient.get(
        'questions',
        requiresToken: true,
      );

      // Ensure the response is a Map<String, dynamic>
      if (response is! Map<String, dynamic>) {
        throw ApiException(
          message: 'Invalid response format: Expected a JSON object',
          statusCode: 500,
        );
      }

      // Extract questions array from response
      final questionsData = response['questions'];
      if (questionsData is! List) {
        throw ApiException(
          message: 'Invalid response format: Questions field is not an array',
          statusCode: 500,
        );
      }

      // Parse the questions into QuestionRequestModel objects
      final questions = questionsData
          .map((e) => QuestionRequestModel.fromJson(e as Map<String, dynamic>))
          .toList();

      Log.d('Successfully fetched ${questions.length} questions');
      return Right(questions);
    } on ApiException catch (e) {
      Log.e('ApiException in fetchQuestions: ${e.message}');
      return Left(e);
    } catch (e) {
      Log.e('Unexpected error in fetchQuestions: $e');
      return Left(
        ApiException(
          message: 'Failed to fetch questions: $e',
          statusCode: 500,
        ),
      );
    }
  }

  @override
  Future<Either<ApiException, ResultResponseModel>> submitAnswers(
      QuestionRequestModel request) async {
    try {
      Log.d('Submitting answers to remote data source...');
      final response = await _apiClient.post(
        'questions/check',
        data: request.toJson(),
        requiresToken: true,
      );

      print(response);
      print(request.toJson());

      // Ensure the response is a Map<String, dynamic>
      if (response is! Map<String, dynamic>) {
        throw ApiException(
          message: 'Invalid response format: Expected a map',
          statusCode: 500,
        );
      }

      // Parse the response into a ResultResponseModel
      final resultResponse = ResultResponseModel.fromJson(response);
      print(resultResponse);

      Log.d('Successfully submitted answers: ${resultResponse.message}');
      return Right(resultResponse);
    } on ApiException catch (e) {
      Log.e('ApiException in submitAnswers: ${e.message}');
      return Left(e);
    } catch (e) {
      Log.e('Unexpected error in submitAnswers: $e');
      return Left(
        ApiException(
          message: 'Failed to submit answers: $e',
          statusCode: 500,
        ),
      );
    }
  }
}
