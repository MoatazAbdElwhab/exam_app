import 'package:exam_app/features/explore/data/models/subjects_response/subject_model.dart';
import 'package:exam_app/features/explore/data/repo/explore_repo_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'explore_state.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit(this._exploreRepoImpl) : super(ExploreInitial()) {
    getSubjects();
  }
  final ExploreRepoImpl _exploreRepoImpl;

  Future<void> getSubjects() async {
    emit(GetSubjetcsLoading());
    final result = await _exploreRepoImpl.getSubjects();
    result.fold(
      (fail) => emit(GetSubjetcsFail(fail.toString())),
      (subjects) => emit(GetSubjetcsSuccess(subjects)),
    );
  }
}
