// features/explore/presentation/cubit/explore_state.dart
part of 'explore_cubit.dart';

@immutable
abstract class ExploreState {}

class ExploreInitial extends ExploreState {}

class GetSubjetcsLoading extends ExploreState {}

class GetSubjetcsSuccess extends ExploreState {
  final List<SubjectModel> subjects;

  GetSubjetcsSuccess(this.subjects);
}

class GetSubjetcsFail extends ExploreState {
  final String error;

  GetSubjetcsFail(this.error);
}

class GetExamsLoading extends ExploreState {}

class GetExamsSuccess extends ExploreState {
  final List<ExamModel> exams;

  GetExamsSuccess(this.exams);
}

class GetExamsFail extends ExploreState {
  final String error;

  GetExamsFail(this.error);
}

class GetQuestionsLoading extends ExploreState {}

class GetQuestionsSuccess extends ExploreState {
  final List<QuestionModel> questions;

  GetQuestionsSuccess(this.questions);
}

class GetQuestionsFail extends ExploreState {
  final String error;

  GetQuestionsFail(this.error);
}

class ChangeAnswer extends ExploreState {}

class ExamCompleted extends ExploreState {
  final dynamic result;
  ExamCompleted(this.result);
}


