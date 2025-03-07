// features/result/data/data_sources/result_local_data_source.dart

import 'package:exam_app/core/app_data/api/api_client.dart';
import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:exam_app/core/di/injectable.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:injectable/injectable.dart';

abstract class ResultLocalDataSource {
  Future<List<QuestionRequestModel>> fetchQuestions();
  Map<String, UserQuestionData> getUserAnswers();
}

@LazySingleton(as: ResultLocalDataSource)
class ResultLocalDataSourceImpl implements ResultLocalDataSource {
  final ApiClient _apiClient;

  ResultLocalDataSourceImpl(this._apiClient);

  @override
  Future<List<QuestionRequestModel>> fetchQuestions() async {
    final localStorage = getIt<LocalStorageClient>();
    final questionIds = <String>[];

    // Collect all question IDs first
    for (var i = 0; i < 11; i++) {
      final questionId = localStorage.getData('QuestionID$i');
      if (questionId != null) {
        questionIds.add(questionId);
      }
    }

    if (questionIds.isEmpty) return [];

    try {
      final questions = <QuestionRequestModel>[];
      for (final id in questionIds) {
        final response = await _apiClient.get(
          '/questions/$id',
          requiresToken: true,
        );

        if (response != null && response['question'] != null) {
          final questionData = response['question'] as Map<String, dynamic>;
          final answers = (questionData['answers'] as List)
              .map((answer) => AnswerModel(
                    key: answer['key'],
                    answer: answer['answer'],
                  ))
              .toList();

          questions.add(QuestionRequestModel(
            id: questionData['_id'],
            question: questionData['question'],
            correct: questionData['correct'],
            answers: answers,
            type: questionData['type'],
            subject: questionData['subject'] != null
                ? SubjectModel(
                    id: questionData['subject']['_id'],
                    name: questionData['subject']['name'],
                    icon: questionData['subject']['icon'],
                  )
                : null,
            exam: questionData['exam'] != null
                ? ExamModel(
                    id: questionData['exam']['_id'],
                    title: questionData['exam']['title'],
                    duration: questionData['exam']['duration'],
                  )
                : null,
          ));
        }
      }
      return questions;
    } catch (e) {
      return [];
    }
  }

  @override
  Map<String, UserQuestionData> getUserAnswers() {
    final localStorage = getIt<LocalStorageClient>();
    final userAnswers = <String, UserQuestionData>{};

    // Get all user answers
    for (var i = 0; i < 11; i++) {
      final questionId = localStorage.getData('QuestionID$i');
      final userAnswer = localStorage.getData('Chosen$i');

      if (questionId != null && userAnswer != null) {
        userAnswers[questionId] = UserQuestionData(
          questionId: questionId,
          userAnswer: userAnswer,
        );
      }
    }

    return userAnswers;
  }
}
