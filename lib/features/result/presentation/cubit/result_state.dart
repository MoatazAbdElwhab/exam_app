// features/result/presentation/cubit/result_state.dart

import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/domain/entities/question_request.dart';
import 'package:exam_app/features/result/domain/entities/result_response.dart';

abstract class ResultState {}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {}

class QuestionsLoaded extends ResultState {
  final List<QuestionRequestModel> questions;
  QuestionsLoaded(this.questions);
}

class AnswersSubmitted extends ResultState {
  final ResultResponse response;
  AnswersSubmitted(this.response);
}

class ResultError extends ResultState {
  final String message;
  ResultError(this.message);
}