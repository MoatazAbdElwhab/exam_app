import 'package:exam_app/core/app_data/api/api_client.dart';
import 'package:exam_app/core/app_data/api/api_constants.dart';
import 'package:exam_app/features/explore/data/data_source/remote/explore_remote_data_source.dart';
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

    final subjectRes = SubjectsResponse.fromJson(response);
    return subjectRes.subjects;
  }
}
