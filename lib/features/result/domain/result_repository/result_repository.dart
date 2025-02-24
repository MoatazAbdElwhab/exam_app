// features/result/domain/result_repository/result_repository.dart
import 'package:either_dart/either.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/data/data_models/result_response_model.dart';

abstract class ResultRepository {
  Future<Either<ApiException, List<QuestionRequestModel>>> fetchQuestions();
  Future<Either<ApiException, ResultResponseModel>> submitAnswers(
      QuestionRequestModel request);
}
