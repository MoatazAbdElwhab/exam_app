// features/result/data/repositories/result_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:exam_app/core/error/failures.dart';
import 'package:exam_app/features/result/data/data_models/check_answer_request_model.dart';
import 'package:exam_app/features/result/data/data_models/check_answer_response_model.dart';
import 'package:exam_app/features/result/data/data_models/question_response_model.dart';
import 'package:exam_app/features/result/domain/result_repository/result_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResultRepository)
class ResultRepositoryImpl implements ResultRepository {
  final Dio _dio;

  ResultRepositoryImpl(this._dio);

  @override
  Future<Either<Failure, List<QuestionModel>>> fetchQuestions() async {
    try {
      final response = await _dio.get(
        'https://exam.elevateegy.com/api/v1/questions',
      );

      if (response.statusCode == 200) {
        final questionResponse = QuestionResponseModel.fromJson(response.data);
        return Right(questionResponse.questions);
      } else {
        return Left(ServerFailure(response.data['message'] ?? 'Server Error'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CheckAnswerResponseModel>> submitAnswers(
    CheckAnswerRequestModel request,
  ) async {
    try {
      final response = await _dio.post(
        'https://exam.elevateegy.com/api/v1/questions/check',
        data: request.toJson(),
      );

      if (response.statusCode == 200) {
        final checkResponse = CheckAnswerResponseModel.fromJson(response.data);
        return Right(checkResponse);
      } else {
        return Left(ServerFailure(response.data['message'] ?? 'Server Error'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
