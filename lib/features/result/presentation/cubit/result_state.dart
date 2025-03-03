// features/result/presentation/cubit/result_state.dart
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
  final Map<String, UserQuestionData> userAnswers;

  const QuestionsLoaded({
    required this.questions,
    required this.userAnswers,
  });

  @override
  List<Object?> get props => [questions, userAnswers];
}

class ResultError extends ResultState {
  final String message;

  const ResultError(this.message);

  @override
  List<Object?> get props => [message];
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
