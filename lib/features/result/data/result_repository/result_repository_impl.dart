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
     // debugPrint('Fetching QuestionModelHive instances from storage');
      final questions = await _storageClient.getAllCachedQuestions();
      
      if (questions.isEmpty) {
      //  debugPrint('No cached questions found - new user case');
        return Left(CacheNotFoundException(message: _getWelcomeMessage()));
      }
      
      //debugPrint('Retrieved ${questions.length} QuestionModelHive instances with answes property');
      return Right(questions);
    } on LocalStorageException catch (e) {
     // debugPrint('Storage exception while getting QuestionModelHive: ${e.message}');
      return Left(e);
    } catch (e) {
     // debugPrint('Unexpected error while getting QuestionModelHive: $e');
      return Left(CacheReadException());
    }
  }

  @override
  Future<Either<LocalStorageException, ExamScore>> calculateScore(List<QuestionModelHive> questions) async {
    try {
      if (_isQuestionsEmpty(questions)) {
       // debugPrint('No QuestionModelHive instances available for scoring');
        return Left(CacheNotFoundException());
      }

     // debugPrint('Calculating score using QuestionModelHive.answes property');
      final score = _calculateExamScoreFromHiveModel(questions);
     // debugPrint('Score calculation complete: ${score.correctAnswers}/${score.totalQuestions}');
      return Right(score);
    } on LocalStorageException catch (e) {
     // debugPrint('Storage exception in score calculation: ${e.message}');
      return Left(e);
    } catch (e) {
      //debugPrint('Error calculating score from QuestionModelHive: $e');
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

    //debugPrint('Score calculation details:');
    //debugPrint('- Total QuestionModelHive instances: $totalQuestions');
    //debugPrint('- Correct answers using answes property: $correctAnswers');
    //debugPrint('- Score percentage: ${scorePercentage.toStringAsFixed(1)}%');

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

    //  debugPrint('Checking question: ${question.question}');
     // debugPrint('User answer key: $userAnswer');
     // debugPrint('Correct answer key: $correctAnswer');
     // debugPrint('Available answers: ${question.answes.join(", ")}');
      
      if (userAnswer != null && userAnswer == correctAnswer) {
    //    debugPrint('Found correct answer! Key: $userAnswer');
        correctCount++;
      }
    }
   // debugPrint('Total correct answers: $correctCount');
    return correctCount;
  }

  double _calculateScorePercentage(int correctAnswers, int totalQuestions) {
    final percentage = (correctAnswers / totalQuestions) * 100;
   // debugPrint('Calculated percentage from QuestionModelHive answers: ${percentage.toStringAsFixed(1)}%');
    return percentage;
  }
}
