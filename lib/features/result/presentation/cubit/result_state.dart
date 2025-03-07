// features/result/presentation/cubit/result_state.dart
part of 'result_cubit.dart';

enum ResultStatus {
  initial,
  loading,
  questionsLoaded,
  error,
  answerSubmitted,
  allAnswersSubmitted,
  historyLoaded
}

class ResultState extends Equatable {
  final ResultStatus status;
  final List<QuestionRequestModel>? questions;
  final Map<String, UserQuestionData>? userAnswers;
  final ResultResponseModel? response;
  final HistoryResponseModel? history;
  final String? errorMessage;

  const ResultState({
    this.status = ResultStatus.initial,
    this.questions,
    this.userAnswers,
    this.response,
    this.history,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, questions, userAnswers, response, history, errorMessage];

  ResultState copyWith({
    ResultStatus? status,
    List<QuestionRequestModel>? questions,
    Map<String, UserQuestionData>? userAnswers,
    ResultResponseModel? response,
    HistoryResponseModel? history,
    String? errorMessage,
  }) {
    return ResultState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      userAnswers: userAnswers ?? this.userAnswers,
      response: response ?? this.response,
      history: history ?? this.history,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  // Factory constructors for different states
  factory ResultState.initial() => const ResultState();

  factory ResultState.loading() => const ResultState(status: ResultStatus.loading);

  factory ResultState.questionsLoaded({
    required List<QuestionRequestModel> questions,
    required Map<String, UserQuestionData> userAnswers,
  }) => ResultState(
    status: ResultStatus.questionsLoaded,
    questions: questions,
    userAnswers: userAnswers,
  );

  factory ResultState.error(String message) => ResultState(
    status: ResultStatus.error,
    errorMessage: message,
  );

  factory ResultState.answerSubmitted(ResultResponseModel response) => ResultState(
    status: ResultStatus.answerSubmitted,
    response: response,
  );

  factory ResultState.allAnswersSubmitted(List<QuestionRequestModel> questions) => ResultState(
    status: ResultStatus.allAnswersSubmitted,
    questions: questions,
  );

  factory ResultState.historyLoaded(HistoryResponseModel history) => ResultState(
    status: ResultStatus.historyLoaded,
    history: history,
  );
}
