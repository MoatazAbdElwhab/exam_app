// features/result/domain/use_cases/submit_answers.dart

import 'package:either_dart/either.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/domain/entities/result_response.dart';
import 'package:exam_app/features/result/domain/result_repository/result_repository.dart';
import 'package:injectable/injectable.dart';


@singleton
class SubmitAnswers {
  final ResultRepository repository;

  SubmitAnswers(this.repository);

  Future<Either<ApiException, ResultResponse>> call(QuestionRequestModel request) async {
    return await repository.submitAnswers(request);
  }
}