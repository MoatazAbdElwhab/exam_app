import 'package:exam_app/core/app_data/api/api_client.dart';
import 'package:exam_app/core/app_data/api/api_constants.dart';
import 'package:exam_app/features/explore/data/data_source/remote/explore_remote_data_source.dart';
import 'package:exam_app/features/explore/data/models/exam_response/exam_model.dart';
import 'package:exam_app/features/explore/data/models/exam_response/exam_response.dart';
import 'package:exam_app/features/explore/data/models/questions_response/question_model.dart';
import 'package:exam_app/features/explore/data/models/questions_response/questions_response.dart';
import 'package:exam_app/features/explore/data/models/subjects_response/subject_model.dart';
import 'package:exam_app/features/explore/data/models/subjects_response/subjects_response.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ExploreRemoteDataSource)
class ExploreApiRemoteDataSource implements ExploreRemoteDataSource {
  final ApiClient _apiClient;

  ExploreApiRemoteDataSource(this._apiClient);
  @override
  Future<List<SubjectModel>> getSubjects() async {
    final response = await _apiClient.get(
      ApiConstants.getAllSubjectsEndpoint,
      requiresToken: true,
    );

    return SubjectsResponse.fromJson(response).subjects;
  }

  @override
  Future<List<ExamModel>> getAllExamOnSubject(String subjectID) async {
    final response = await _apiClient.get(
      ApiConstants.getAllExamsOnSubjectEndpoint,
      queryParameters: {
        ApiConstants.subjectKey: subjectID,
      },
      requiresToken: true,
    );
    return ExamResponse.fromJson(response).exams;
  }

  @override
  Future<List<QuestionModel>> getAllQuestionsOnExam(String examID) async {
    final response = await _apiClient.get(
      ApiConstants.getAllQuestionsOnExamEndpoint,
      queryParameters: {
        ApiConstants.examKey: examID,
      },
      requiresToken: true,
    );
    return QuestionsResponse.fromJson(response).questions;
  }
}
