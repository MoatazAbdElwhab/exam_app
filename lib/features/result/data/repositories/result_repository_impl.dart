// features/result/data/repositories/result_repository_impl.dart
import 'package:either_dart/either.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';
import 'package:exam_app/features/result/data/data_models/history_response_model.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/data/data_models/result_response_model.dart';
import 'package:exam_app/features/result/data/data_sources/result_local_data_source.dart';
import 'package:exam_app/features/result/data/data_sources/result_remote_data_source.dart';
import 'package:exam_app/features/result/domain/result_repository/result_repository.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ResultRepository)
class ResultRepositoryImpl implements ResultRepository {
  final ResultLocalDataSource _localDataSource;
  final ResultRemoteDataSource _remoteDataSource;

  ResultRepositoryImpl(this._localDataSource, this._remoteDataSource);

  @override
  Future<Either<ApiException, List<QuestionRequestModel>>> fetchQuestions() async {
    try {
      final questions = await _localDataSource.fetchQuestions();
      return Right(questions);
    } catch (e) {
      return Left(ApiException(message:  e.toString()));
    }
  }

  Map<String, UserQuestionData> getUserAnswers() {
    try {
      return _localDataSource.getUserAnswers();
    } catch (e) {
      return {};
    }
  }

  @override
  Future<Either<ApiException, ResultResponseModel>> submitAnswers(QuestionRequestModel request) async {
    try {
      final result = await _remoteDataSource.submitAnswers(request);
      return result.fold(
        (error) => Left(error),
        (response) => Right(response),
      );
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  @override
  Future<Either<ApiException, HistoryResponseModel>> fetchHistory() async {
    try {
      final result = await _remoteDataSource.fetchHistory();
      return result.fold(
        (error) => Left(error),
        (response) => Right(response),
      );
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}
