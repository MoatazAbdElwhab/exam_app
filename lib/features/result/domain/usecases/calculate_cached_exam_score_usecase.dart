// features/result/domain/usecases/calculate_cached_exam_score_usecase.dart
import 'package:either_dart/either.dart';
import 'package:exam_app/core/error_handling/exceptions/storage/local_storage_exception.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:exam_app/features/result/domain/entities/exam_score.dart';
import 'package:exam_app/features/result/domain/repositories/result_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class CalculateCachedExamScoreUseCase {
  final ResultRepository _repository;

  CalculateCachedExamScoreUseCase(this._repository);

  Future<Either<LocalStorageException, ExamScore>> call(List<QuestionModelHive> questions) async {
    return await _repository.calculateScore(questions);
  }
}
