// features/result/presentation/cubit/result_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:exam_app/core/di/injectable.dart';
import 'package:exam_app/features/result/data/data_models/history_response_model.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/data/data_models/result_response_model.dart';
import 'package:exam_app/features/result/domain/result_repository/result_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

part 'result_state.dart';

@injectable
class ResultCubit extends Cubit<ResultState> {
  final ResultRepository _resultRepository;
  List<QuestionRequestModel> _questions = [];
  final Map<String, UserQuestionData> _userAnswers = {};

  ResultCubit(this._resultRepository) : super(ResultInitial());

  void fetchQuestions() async {
    emit(ResultLoading());
    try {
      // Get stored question IDs and answers
      _userAnswers.clear();
      final localStorage = getIt<LocalStorageClient>();
      
      // First get all question IDs and answers
      for (var i = 0; i < 11; i++) {
        final questionId = localStorage.getData('QuestionID$i');
        final chosenAnswer = localStorage.getData('Chosen$i');
        
        if (questionId != null && chosenAnswer != null) {
          debugPrint('Found Question $i - ID: $questionId, Answer: $chosenAnswer');
          _userAnswers[questionId] = UserQuestionData(
            questionId: questionId,
            userAnswer: chosenAnswer,
          );
        }
      }

      debugPrint('User Answers Map: $_userAnswers');

      final result = await _resultRepository.fetchQuestions();
      result.fold(
        (failure) => emit(ResultError(failure.message)),
        (questions) {
          _questions = questions;
          // question's correct answer
          for (var q in questions) {
            final userAnswer = _userAnswers[q.id];
            debugPrint('Question ${q.id}:');
            debugPrint('- Correct Answer: ${q.correct}');
            debugPrint('- User Answer: ${userAnswer?.userAnswer}');
            debugPrint('- Match: ${userAnswer?.userAnswer == q.correct}');
          }
          emit(QuestionsLoaded(
            questions: questions,
            userAnswers: _userAnswers,
          ));
        },
      );
    } catch (e) {
      emit(ResultError(e.toString()));
    }
  }

  Future<void> submitAnswer(QuestionRequestModel request) async {
    try {
      
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
        emit(QuestionsLoaded(
          questions: _questions,
          userAnswers: _userAnswers,
        ));
      }

      
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
            emit(QuestionsLoaded(
              questions: _questions,
              userAnswers: _userAnswers,
            ));
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

class UserQuestionData {
  final String questionId;
  final String userAnswer;

  UserQuestionData({
    required this.questionId,
    required this.userAnswer,
  });

  @override
  String toString() => 'UserQuestionData(questionId: $questionId, userAnswer: $userAnswer)';
}
