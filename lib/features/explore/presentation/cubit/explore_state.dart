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

final class GetExamsLoading extends ExploreState {}

final class GetExamsFail extends ExploreState {
  final String errorMsg;

  GetExamsFail(this.errorMsg);
}

final class GetExamsSuccess extends ExploreState {
  final List<ExamModel> exams;

  GetExamsSuccess(this.exams);
}

final class GetQuestionsLoading extends ExploreState {}

final class GetQuestionsFail extends ExploreState {
  final String errorMsg;

  GetQuestionsFail(this.errorMsg);
}

final class GetQuestionsSuccess extends ExploreState {
  final List<QuestionModel> questions;

  GetQuestionsSuccess(this.questions);
}
