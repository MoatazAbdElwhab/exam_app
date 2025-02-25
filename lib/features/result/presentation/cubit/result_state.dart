part of 'result_cubit.dart';

abstract class ResultState extends Equatable {
  const ResultState();

  @override
  List<Object?> get props => [];
}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {}

class QuestionsLoaded extends ResultState {
  final List<QuestionModel> questions;

  const QuestionsLoaded(this.questions);

  @override
  List<Object?> get props => [questions];
}

class ResultAnswerSubmitted extends ResultState {
  final CheckAnswerResponseModel response;

  const ResultAnswerSubmitted(this.response);

  @override
  List<Object?> get props => [response];
}

class ResultAllAnswersSubmitted extends ResultState {
  final CheckAnswerResponseModel response;

  const ResultAllAnswersSubmitted(this.response);

  @override
  List<Object?> get props => [response];
}

class ResultError extends ResultState {
  final String message;

  const ResultError(this.message);

  @override
  List<Object?> get props => [message];
}
