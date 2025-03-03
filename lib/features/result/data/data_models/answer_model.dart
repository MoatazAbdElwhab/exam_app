// features/result/data/data_models/answer_model.dart

import '../../domain/entities/answer.dart';

class AnswerModel extends Answer {
  final String? id;
  final String? text;

  AnswerModel({
    this.id,
    this.text,
  }) : super(
          answer: text,
          key: id,
        );

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        id: json['id'] as String?,
        text: json['text'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
      };
}
