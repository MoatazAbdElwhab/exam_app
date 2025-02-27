// features/result/data/repositories/result_repository_impl.dart
import 'package:either_dart/either.dart';
import 'package:exam_app/features/result/data/data_models/history_response_model.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/data/data_models/result_response_model.dart';
import 'package:exam_app/features/result/domain/result_repository/result_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';
import 'package:exam_app/features/result/data/data_sources/result_remote_data_source.dart';

@Injectable(as: ResultRepository)
class ResultRepositoryImpl implements ResultRepository {
  final ResultRemoteDataSource _remoteDataSource;

  ResultRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<ApiException, List<QuestionRequestModel>>> fetchQuestions() async {
    return await _remoteDataSource.fetchQuestions();
  }

  @override
  Future<Either<ApiException, ResultResponseModel>> submitAnswers(QuestionRequestModel request) async {
    return await _remoteDataSource.submitAnswers(request);
  }

  @override
  Future<Either<ApiException, HistoryResponseModel>> fetchHistory() async {
    return await _remoteDataSource.fetchHistory();
  }
}
