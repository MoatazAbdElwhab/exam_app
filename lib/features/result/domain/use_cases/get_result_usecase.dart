// features/result/domain/use_cases/get_result_usecase.dart
import 'package:either_dart/either.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';
import 'package:exam_app/features/result/domain/entities/question_request.dart';
import 'package:exam_app/features/result/domain/result_repository/result_repository.dart';
import 'package:injectable/injectable.dart';


@singleton
class FetchQuestions {
  final ResultRepository repository;

  FetchQuestions(this.repository);

  Future <Either <ApiException, List<QuestionRequest>>> call() async {
    return await repository.fetchQuestions();
  }
}
