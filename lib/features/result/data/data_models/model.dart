// features/result/data/data_models/model.dart
// features/result/data/models/answer_model.dart
import 'package:exam_app/features/result/domain/entities/answer.dart';

class AnswerModel extends Answer {
  final String? answer;
  final String? key;

  AnswerModel({
    this.answer,
    this.key,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        answer: json['answer'],
        key: json['key'],
      );

  Map<String, dynamic> toJson() => {
        'answer': answer,
        'key': key,
      };
}
