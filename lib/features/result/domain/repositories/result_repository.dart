// features/result/domain/repositories/result_repository.dart
import 'package:either_dart/either.dart';
import 'package:exam_app/core/error_handling/exceptions/storage/local_storage_exception.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:exam_app/features/result/domain/entities/exam_score.dart';

abstract class ResultRepository {
  /// Get cached questions directly using QuestionModelHive
  Future<Either<LocalStorageException, List<QuestionModelHive>>> getCachedQuestions();

  /// Calculate score using QuestionModelHive list
  Future<Either<LocalStorageException, ExamScore>> calculateScore(List<QuestionModelHive> questions);
}
