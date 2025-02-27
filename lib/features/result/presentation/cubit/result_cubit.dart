// features/result/presentation/cubit/result_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exam_app/features/result/data/data_models/history_response_model.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/data/data_models/result_response_model.dart';
import 'package:exam_app/features/result/domain/result_repository/result_repository.dart';
import 'package:injectable/injectable.dart';

part 'result_state.dart';

@injectable
class ResultCubit extends Cubit<ResultState> {
  final ResultRepository _resultRepository;
  List<QuestionRequestModel> _questions = [];

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

  Future<void> submitAnswer(QuestionRequestModel request) async {
    try {
      // Update the question in our local state
      final questionIndex = _questions.indexWhere((q) => q.id == request.id);
      if (questionIndex != -1) {
        _questions[questionIndex] = QuestionRequestModel(
          id: request.id,
          question: request.question,
          answers: request.answers,
          type: request.type,
          correct: request.correct,
          subject: request.subject,
          exam: request.exam,
          createdAt: request.createdAt,
          selectedAnswer: request.selectedAnswer,
        );
        emit(QuestionsLoaded(_questions));
      }

      // Submit to server
      final result = await _resultRepository.submitAnswers(request);
      result.fold(
        (error) {
          // If error, revert the question state
          if (questionIndex != -1) {
            _questions[questionIndex] = QuestionRequestModel(
              id: _questions[questionIndex].id,
              question: _questions[questionIndex].question,
              answers: _questions[questionIndex].answers,
              type: _questions[questionIndex].type,
              correct: _questions[questionIndex].correct,
              subject: _questions[questionIndex].subject,
              exam: _questions[questionIndex].exam,
              createdAt: _questions[questionIndex].createdAt,
              selectedAnswer: null,
            );
            emit(QuestionsLoaded(_questions));
          }
          emit(ResultError(error.message));
        },
        (response) => emit(ResultAnswerSubmitted(response)),
      );
    } catch (e) {
      emit(ResultError(e.toString()));
    }
  }

  Future<void> submitAllAnswers() async {
    emit(ResultAllAnswersSubmitted(_questions));
  }

  Future<void> fetchHistory() async {
    emit(ResultLoading());
    try {
      final result = await _resultRepository.fetchHistory();
      result.fold(
        (error) => emit(ResultError(error.message)),
        (history) => emit(HistoryLoaded(history)),
      );
    } catch (e) {
      emit(ResultError(e.toString()));
    }
  }
}
