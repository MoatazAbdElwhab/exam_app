import 'package:exam_app/features/explore/data/models/subjects_response/subject_model.dart';

abstract class ExploreRemoteDataSource {
  Future<List<SubjectModel>> getSubjects();
}
