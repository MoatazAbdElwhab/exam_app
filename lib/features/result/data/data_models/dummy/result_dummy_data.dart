// features/result/data/dummy/result_dummy_data.dart

import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/data/data_models/result_response_model.dart';

class ResultDummyData {
  static List<QuestionRequestModel> get questions => [
        const QuestionRequestModel(
          id: '1',
          question: 'What is the capital of France?',
          type: 'mcq',
          answers: null,
          selectedAnswer: null,
          correct: 'Paris',
          exam: null,
          subject: null,
          createdAt: '2025-02-27T20:48:56.000Z',
        ),
      ];

  static ResultResponseModel get resultResponse => const ResultResponseModel(
        message: 'Success',
        correct: 1,
        wrong: 0,
        total: '1',
        wrongQuestions: [],
        correctQuestions: [],
      );
}
