part of 'explore_cubit.dart';

sealed class ExploreState {}

final class ExploreInitial extends ExploreState {}

final class GetSubjetcsLoading extends ExploreState {}

final class GetSubjetcsFail extends ExploreState {
  final String errorMsg;

  GetSubjetcsFail(this.errorMsg);
}

final class GetSubjetcsSuccess extends ExploreState {
  final List<SubjectModel> subjects;

  GetSubjetcsSuccess(this.subjects);
}
