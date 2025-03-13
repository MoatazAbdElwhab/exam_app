// features/result/domain/usecases/get_cached_exam_questions_usecase.dart
import 'package:either_dart/either.dart';
import 'package:exam_app/core/error_handling/exceptions/storage/local_storage_exception.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:exam_app/features/result/domain/repositories/result_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCachedExamQuestionsUseCase {
  final ResultRepository _repository;

  GetCachedExamQuestionsUseCase(this._repository);

  Future<Either<LocalStorageException, List<QuestionModelHive>>> call() async {
    return await _repository.getCachedQuestions();
  }
}
