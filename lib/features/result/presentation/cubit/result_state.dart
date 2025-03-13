// features/result/presentation/cubit/result_state.dart
import 'package:equatable/equatable.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:exam_app/features/result/domain/entities/exam_score.dart';

enum ResultStatus { 
  initial, 
  loading, 
  loaded, 
  error 
}

class ResultState extends Equatable {
  final ResultStatus status;
  final List<QuestionModelHive>? questions;
  final ExamScore? examScore;
  final String? errorMessage;

  const ResultState._({
    required this.status,
    this.questions,
    this.examScore,
    this.errorMessage,
  });

  // Factory constructors for clean state transitions
  factory ResultState.initial() => const ResultState._(status: ResultStatus.initial);

  factory ResultState.loading() => const ResultState._(status: ResultStatus.loading);

  factory ResultState.loaded({
    required List<QuestionModelHive> questions,
    required ExamScore examScore,
  }) =>
      ResultState._(
        status: ResultStatus.loaded,
        questions: questions,
        examScore: examScore,
      );

  factory ResultState.error(String message) => ResultState._(
        status: ResultStatus.error,
        errorMessage: message,
      );

  // Helper getters for state checks
  bool get isInitial => status == ResultStatus.initial;
  bool get isLoading => status == ResultStatus.loading;
  bool get isLoaded => status == ResultStatus.loaded;
  bool get isError => status == ResultStatus.error;

  // For checking if questions are available and have answers
  bool get hasQuestions => questions != null && questions!.isNotEmpty;
  bool get hasAnswers => hasQuestions && questions!.any((q) => q.answes != null);

  @override
  List<Object?> get props => [status, questions, examScore, errorMessage];

  @override
  String toString() {
    switch (status) {
      case ResultStatus.initial:
        return 'ResultState.initial';
      case ResultStatus.loading:
        return 'ResultState.loading';
      case ResultStatus.loaded:
        return 'ResultState.loaded(questions: ${questions?.length}, score: ${examScore?.scorePercentage.toStringAsFixed(1)}%)';
      case ResultStatus.error:
        return 'ResultState.error(message: $errorMessage)';
    }
  }
}
