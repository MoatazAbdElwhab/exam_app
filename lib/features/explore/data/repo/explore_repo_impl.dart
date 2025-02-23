import 'package:either_dart/either.dart';
import 'package:exam_app/core/error_handling/exceptions/api_exception.dart';
import 'package:exam_app/features/explore/data/data_source/remote/explore_remote_data_source.dart';
import 'package:exam_app/features/explore/data/models/subjects_response/subject_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExploreRepoImpl {
  final ExploreRemoteDataSource _dataSource;

  ExploreRepoImpl(this._dataSource);

  Future<Either<Exception, List<SubjectModel>>> getSubjects() async {
    try {
      final subjects = await _dataSource.getSubjects();
      return Right(subjects);
    } catch (e) {
      return Left(ApiException(message: e.toString()));
    }
  }
}
