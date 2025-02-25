// features/result/domain/result_repository/result_repository.dart
import 'package:dartz/dartz.dart';
import 'package:exam_app/core/error/failures.dart';
import 'package:exam_app/features/result/data/data_models/check_answer_request_model.dart';
import 'package:exam_app/features/result/data/data_models/check_answer_response_model.dart';
import 'package:exam_app/features/result/data/data_models/question_response_model.dart';

abstract class ResultRepository {
  Future<Either<Failure, List<QuestionResponseModel>>> fetchQuestions();
  Future<Either<Failure, CheckAnswerResponseModel>> submitAnswers(
    CheckAnswerRequestModel request,
  );
}
