// features/result/data/data_models/model.dart
// features/result/data/models/answer_model.dart
import 'package:exam_app/features/result/domain/entities/answer.dart';

class AnswerModel extends Answer {
  AnswerModel({super.questionId, super.correct});

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        questionId: json['questionId'],
        correct: json['correct'],
      );

  Map<String, dynamic> toJson() => {
        'questionId': questionId,
        'correct': correct,
      };
}




