// features/result/presentation/cubit/result_cubit.dart
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/domain/result_repository/result_repository.dart';
import 'package:exam_app/features/result/presentation/cubit/result_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResultCubit extends Cubit<ResultState> {
  final ResultRepository _repository;

  ResultCubit(this._repository) : super(ResultInitial());

  Future<void> fetchQuestions() async {
    emit(ResultLoading());
    final result = await _repository.fetchQuestions();
    result.fold(
      (error) => emit(ResultError(error.message)),
      (questions) => emit(QuestionsLoaded(questions)),
    );
  }

  Future<void> submitAnswers(QuestionRequestModel request) async {
    emit(ResultLoading());
    final result = await _repository.submitAnswers(request);
    result.fold(
      (error) => emit(ResultError(error.message)),
      (response) => emit(AnswersSubmitted(response)),
    );
  }
}