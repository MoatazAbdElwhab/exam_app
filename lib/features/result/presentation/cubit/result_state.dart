// features/result/presentation/cubit/result_state.dart
import 'package:equatable/equatable.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:exam_app/features/result/domain/entities/exam_score.dart';

enum ResultStatus { 
  loading, 
  loaded, 
  error 
}

class ResultState extends Equatable {
  final ResultStatus status;
  final List<QuestionModelHive>? questions;
  final ExamScore? examScore;
  final String? errorMessage;

  const ResultState({
    this.status = ResultStatus.loading,
    this.questions,
    this.examScore,
    this.errorMessage,
  });

  bool get isLoading => status == ResultStatus.loading;
  bool get isLoaded => status == ResultStatus.loaded;
  bool get isError => status == ResultStatus.error;

  ResultState copyWith({
    ResultStatus? status,
    List<QuestionModelHive>? questions,
    ExamScore? examScore,
    String? errorMessage,
  }) {
    return ResultState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      examScore: examScore ?? this.examScore,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, questions, examScore, errorMessage];

  @override
  String toString() {
    switch (status) {
      case ResultStatus.loading:
        return 'ResultState.loading';
      case ResultStatus.loaded:
        return 'ResultState.loaded(questions: ${questions?.length}, score: ${examScore?.scorePercentage.toStringAsFixed(1)}%)';
      case ResultStatus.error:
        return 'ResultState.error(message: $errorMessage)';
    }
  }
}
