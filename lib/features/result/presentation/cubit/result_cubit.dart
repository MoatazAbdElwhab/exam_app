// features/result/presentation/cubit/result_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exam_app/features/result/data/data_models/check_answer_request_model.dart';
import 'package:exam_app/features/result/data/data_models/check_answer_response_model.dart';
import 'package:exam_app/features/result/data/data_models/question_response_model.dart';
import 'package:exam_app/features/result/domain/result_repository/result_repository.dart';
import 'package:injectable/injectable.dart';

part 'result_state.dart';

@injectable
class ResultCubit extends Cubit<ResultState> {
  final ResultRepository _resultRepository;
  List<QuestionModel> _questions = [];
  int _elapsedTime = 0;
  List<AnswerSubmission> _submittedAnswers = [];

  ResultCubit(this._resultRepository) : super(ResultInitial());

  Future<void> fetchQuestions() async {
    emit(ResultLoading());
    try {
      final result = await _resultRepository.fetchQuestions();
      result.fold(
        (error) => emit(ResultError(error.message)),
        (questions) {
          _questions = questions;
          emit(QuestionsLoaded(_questions));
        },
      );
    } catch (e) {
      emit(ResultError(e.toString()));
    }
  }

  Future<void> submitAnswer(String questionId, String selectedAnswer) async {
    try {
      // Update local state
      final questionIndex = _questions.indexWhere((q) => q.id == questionId);
      if (questionIndex == -1) return;

      // Add to submitted answers
      _submittedAnswers.add(AnswerSubmission(
        questionId: questionId,
        correct: selectedAnswer,
      ));

      // Submit to server
      final request = CheckAnswerRequestModel(
        answers: _submittedAnswers,
        time: _elapsedTime,
      );

      final result = await _resultRepository.submitAnswers(request);
      result.fold(
        (error) {
          // Remove from submitted answers on error
          _submittedAnswers.removeWhere((a) => a.questionId == questionId);
          emit(ResultError(error.message));
        },
        (response) {
          emit(ResultAnswerSubmitted(response));
          emit(QuestionsLoaded(_questions));
        },
      );
    } catch (e) {
      emit(ResultError(e.toString()));
    }
  }

  void updateElapsedTime(int seconds) {
    _elapsedTime = seconds;
  }

  Future<void> submitAllAnswers() async {
    if (_submittedAnswers.isEmpty) {
      emit(ResultError('No answers to submit'));
      return;
    }

    emit(ResultLoading());
    try {
      final request = CheckAnswerRequestModel(
        answers: _submittedAnswers,
        time: _elapsedTime,
      );

      final result = await _resultRepository.submitAnswers(request);
      result.fold(
        (error) {
          emit(ResultError(error.message));
          emit(QuestionsLoaded(_questions));
        },
        (response) {
          emit(ResultAllAnswersSubmitted(response));
        },
      );
    } catch (e) {
      emit(ResultError(e.toString()));
      emit(QuestionsLoaded(_questions));
    }
  }
}
