// features/result/data/data_sources/result_local_data_source.dart

import 'package:exam_app/core/app_data/api/api_client.dart';
import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:exam_app/core/di/injectable.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:injectable/injectable.dart';

abstract class ResultLocalDataSource {
  Future<List<QuestionRequestModel>> fetchQuestions();
  Map<int, UserQuestionData> getUserAnswers();
}

@LazySingleton(as: ResultLocalDataSource)
class ResultLocalDataSourceImpl implements ResultLocalDataSource {
  final ApiClient _apiClient;

  ResultLocalDataSourceImpl(this._apiClient);

  @override
  Future<List<QuestionRequestModel>> fetchQuestions() async {
    final questions = <QuestionRequestModel>[];
    final localStorage = getIt<LocalStorageClient>();

    // Get all question IDs from local storage
    for (var i = 0; i < 11; i++) {
      final questionId = localStorage.getData('QuestionID$i');
     // final userAnswer = localStorage.getData('Answer$i');
      
      if (questionId != null) {
        // Fetch question details from API
        final response = await _apiClient.get(
          '/questions/$questionId',
          requiresToken: true,
        );

        final questionData = response['question'] as Map<String, dynamic>;
        final answers = (questionData['answers'] as List)
            .map((answer) => AnswerModel(
                  key: answer['key'],
                  answer: answer['answer'],
                ))
            .toList();

        // Convert response to QuestionRequestModel
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
  }

  @override
  Map<int, UserQuestionData> getUserAnswers() {
    final localStorage = getIt<LocalStorageClient>();
    final userAnswers = <int, UserQuestionData>{};

    // Get all user answers from local storage
    for (var i = 0; i < 11; i++) {
      final questionId = localStorage.getData('QuestionID$i');
      final userAnswer = localStorage.getData('Answer$i');
      
      if (questionId != null && userAnswer != null) {
        userAnswers[int.parse(questionId)] = UserQuestionData(
          questionId: questionId,
          userAnswer: userAnswer,
        );
      }
    }

    return userAnswers;
  }
}
