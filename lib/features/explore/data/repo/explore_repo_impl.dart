import 'package:either_dart/either.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';
import 'package:exam_app/core/error_handling/exceptions/network_exception.dart';
import 'package:exam_app/features/explore/data/data_source/remote/explore_remote_data_source.dart';
import 'package:exam_app/features/explore/data/models/exam_response/exam_model.dart';
import 'package:exam_app/features/explore/data/models/questions_response/question_model.dart';
import 'package:exam_app/features/explore/data/models/subjects_response/subject_model.dart';
import 'package:exam_app/main.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExploreRepoImpl {
  final ExploreRemoteDataSource _dataSource;

  ExploreRepoImpl(this._dataSource);

  Future<Either<Exception, List<SubjectModel>>> getSubjects() async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      final subjects = await _dataSource.getSubjects();
      return Right(subjects);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  Future<Either<Exception, List<ExamModel>>> getAllExamOnSubject(
      String subjectID) async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      final response = await _dataSource.getAllExamOnSubject(subjectID);
      return Right(response);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }

  Future<Either<Exception, List<QuestionModel>>> getAllQuestionsOnExam(
      String examID) async {
    if (!isOnline) {
      return Left(NetworkException('No internet connection'));
    }
    try {
      final response = await _dataSource.getAllQuestionsOnExam(examID);
      return Right(response);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}
