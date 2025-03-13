// features/result/data/result_repository/result_repository_impl.dart
import 'package:either_dart/either.dart';
import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:exam_app/core/error_handling/exceptions/storage/local_storage_exception.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:exam_app/features/result/domain/entities/exam_score.dart';
import 'package:exam_app/features/result/domain/repositories/result_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResultRepository)
class ResultRepositoryImpl implements ResultRepository {
  final LocalStorageClient _storageClient;

  ResultRepositoryImpl(this._storageClient);

  @override
  Future<Either<LocalStorageException, List<QuestionModelHive>>> getCachedQuestions() async {
    try {
      final questions = await _storageClient.getAllCachedQuestions();
      
      if (questions.isEmpty) {
        return Left(CacheNotFoundException(message: _getWelcomeMessage()));
      }
            return Right(questions);
    } on LocalStorageException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CacheReadException());
    }
  }

  @override
  Future<Either<LocalStorageException, ExamScore>> calculateScore(List<QuestionModelHive> questions) async {
    try {
      if (_isQuestionsEmpty(questions)) {
        return Left(CacheNotFoundException());
      }
      final score = _calculateExamScoreFromHiveModel(questions);
      return Right(score);
    } on LocalStorageException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(CacheReadException());
    }
  }

  bool _isQuestionsEmpty(List<QuestionModelHive> questions) => questions.isEmpty;


  String _getWelcomeMessage() => 
      'Welcome! Take your first exam to see your results here.';

  ExamScore _calculateExamScoreFromHiveModel(List<QuestionModelHive> questions) {
    final correctAnswers = _countCorrectAnswersUsingAnswesProperty(questions);
    final totalQuestions = questions.length;
    final scorePercentage = _calculateScorePercentage(correctAnswers, totalQuestions);

    return ExamScore(
      correctAnswers: correctAnswers,
      totalQuestions: totalQuestions,
      scorePercentage: scorePercentage,
    );
  }

  int _countCorrectAnswersUsingAnswesProperty(List<QuestionModelHive> questions) {
   
    int correctCount = 0;
    for (final question in questions) {
      final String? userAnswer = question.userAnswer;
      final String correctAnswer = question.correctAnswer;
      
      if (userAnswer != null && userAnswer == correctAnswer) {
        correctCount++;
      }
    }
    return correctCount;
  }

  double _calculateScorePercentage(int correctAnswers, int totalQuestions) {
    final percentage = (correctAnswers / totalQuestions) * 100;
    return percentage;
  }
}
