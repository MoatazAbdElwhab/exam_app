// features/result/data/data_models/result_response_model.dart
import 'package:exam_app/features/result/data/data_models/wrong_question_model.dart';
import 'package:exam_app/features/result/domain/entities/answers.dart';
import 'package:exam_app/features/result/domain/entities/wrong_question.dart';

import '../../domain/entities/result_response.dart';

class ResultResponseModel extends ResultResponse {
  ResultResponseModel({
    super.message,
    super.correct,
    super.wrong,
    super.total,
    super.wrongQuestions,
    super.correctQuestions,
  });

  factory ResultResponseModel.fromJson(Map<String, dynamic> json) =>
      ResultResponseModel(
        message: json['message'],
        correct: json['correct'],
        wrong: json['wrong'],
        total: json['total'],
        wrongQuestions: (json['WrongQuestions'] as List<dynamic>?)
    ?.map((e) => WrongQuestionModel.fromJson(e as Map<String, dynamic>))
    .map((e) => e as WrongQuestion)
    .toList(),
        correctQuestions: json['correctQuestions'],
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'correct': correct,
        'wrong': wrong,
        'total': total,
        'WrongQuestions':
            wrongQuestions?.map((e) => (e as WrongQuestionModel).toJson()).toList(),
        'correctQuestions': correctQuestions,
      };
}

