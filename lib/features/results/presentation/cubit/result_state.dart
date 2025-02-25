part of 'result_cubit.dart';

abstract class ResultState extends Equatable {
  const ResultState();

  @override
  List<Object?> get props => [];
}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {}

class QuestionsLoaded extends ResultState {
  final List<QuestionRequestModel> questions;

  const QuestionsLoaded(this.questions);

  @override
  List<Object?> get props => [questions];
}

class ResultAnswerSubmitted extends ResultState {
  final ResultResponseModel response;

  const ResultAnswerSubmitted(this.response);

  @override
  List<Object?> get props => [response];
}

class ResultAllAnswersSubmitted extends ResultState {
  final List<QuestionRequestModel> questions;

  const ResultAllAnswersSubmitted(this.questions);

  @override
  List<Object?> get props => [questions];
}

class HistoryLoaded extends ResultState {
  final HistoryResponseModel history;

  const HistoryLoaded(this.history);

  @override
  List<Object?> get props => [history];
}

class ResultError extends ResultState {
  final String message;

  const ResultError(this.message);

  @override
  List<Object?> get props => [message];
}
