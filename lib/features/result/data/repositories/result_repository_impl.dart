// features/result/data/repositories/result_repository_impl.dart
import 'package:either_dart/either.dart';
import 'package:exam_app/features/result/data/data_models/history_response_model.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/data/data_models/result_response_model.dart';
import 'package:exam_app/features/result/data/data_sources/result_local_data_source.dart';
import 'package:exam_app/features/result/data/data_models/dummy/result_dummy_data.dart';
import 'package:exam_app/features/result/domain/result_repository/result_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';

@LazySingleton(as: ResultRepository)
class ResultRepositoryImpl implements ResultRepository {
  final ResultLocalDataSource _localDataSource;

  ResultRepositoryImpl(this._localDataSource);

  @override
  Future<Either<ApiException, List<QuestionRequestModel>>>
      fetchQuestions() async {
    try {
      final questions = [
      const  QuestionRequestModel(
          id: '1',
          question: 'What is the capital of France?',
          type: 'mcq',
          answers: [
            AnswerModel(key: "1", answer: "London"),
            AnswerModel(key: "2", answer: "Paris"),
            AnswerModel(key: "3", answer: "Berlin"),
            AnswerModel(key: "4", answer: "Madrid"),
          ],
          selectedAnswer: '1',
          correct: 'Paris',
          exam: ExamModel(
            id: "exam1",
            title: "Geography Quiz",
            duration: 30,
            numberOfQuestions: 10,
            active: true,
            createdAt: "2025-02-27T20:48:56.000Z",
          ),
          subject: SubjectModel(
            id: "sub1",
            name: "Geography",
            icon: "geography_icon",
            createdAt: "2025-02-27T20:48:56.000Z",
          ),
          createdAt: '2025-02-27T20:48:56.000Z',
        ),
      ];
      return Right(questions);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, ResultResponseModel>> submitAnswers(
      QuestionRequestModel request) async {
    try {
      return Right(ResultDummyData.resultResponse);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, HistoryResponseModel>> fetchHistory() async {
    try {
      return const Right(
        HistoryResponseModel(
          message: "History fetched successfully",
          history: null,
        ),
      );
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}
