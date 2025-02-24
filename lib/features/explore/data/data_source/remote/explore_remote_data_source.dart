import 'package:exam_app/features/explore/data/models/exam_response/exam_model.dart';
import 'package:exam_app/features/explore/data/models/questions_response/question_model.dart';
import 'package:exam_app/features/explore/data/models/subjects_response/subject_model.dart';

abstract class ExploreRemoteDataSource {
  Future<List<SubjectModel>> getSubjects();
  Future<List<ExamModel>> getAllExamOnSubject(String subjectID);
  Future<List<QuestionModel>> getAllQuestionsOnExam(String examID);
}
