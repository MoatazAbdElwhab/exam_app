import 'package:either_dart/either.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/data/data_models/result_response_model.dart';
import 'package:exam_app/features/result/domain/result_repository/result_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckAnswersUseCase {
  final ResultRepository _repository;

  CheckAnswersUseCase(this._repository);

  Future<Either<ApiException, ResultResponseModel>> call(
      QuestionRequestModel request) async {
    return await _repository.submitAnswers(request);
  }
}
