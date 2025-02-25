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
        _questions[questionIndex] = request;
        emit(QuestionsLoaded(_questions));
      }

      // Submit to server
      final result = await _resultRepository.submitAnswers(request);
      result.fold(
        (error) {
          // If error, revert the question state
          if (questionIndex != -1) {
            _questions[questionIndex] = _questions[questionIndex].copyWith(
              selectedAnswer: null,
            );
            emit(QuestionsLoaded(_questions));
          }
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

  Future<void> submitAllAnswers() async {
    if (_questions.isEmpty) {
      emit(ResultError('No questions to submit'));
      return;
    }

    emit(ResultLoading());
    try {
      // Get all questions with answers
      final answeredQuestions = _questions.where((q) => q.selectedAnswer != null).toList();
      
      if (answeredQuestions.isEmpty) {
        emit(ResultError('No answers to submit'));
        return;
      }

      // Submit each answer
      for (final question in answeredQuestions) {
        final result = await _resultRepository.submitAnswers(question);
        final success = await result.fold(
          (error) async {
            emit(ResultError(error.message));
            return false;
          },
          (response) async {
            emit(ResultAnswerSubmitted(response));
            return true;
          },
        );

        if (!success) {
          emit(QuestionsLoaded(_questions));
          return;
        }
      }

      // If all submissions successful, emit final state
      emit(ResultAllAnswersSubmitted(_questions));
    } catch (e) {
      emit(ResultError(e.toString()));
      emit(QuestionsLoaded(_questions));
    }
  }
}
