import 'package:exam_app/core/app_data/api/api_constants.dart';

class AnswerModel {
  final String answer;
  final String key;

  const AnswerModel({
    required this.answer,
    required this.key,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        answer: json[ApiConstants.answerKey] as String,
        key: json[ApiConstants.keyKey] as String,
      );

  Map<String, dynamic> toJson() => {
        ApiConstants.answerKey: answer,
        ApiConstants.keyKey: key,
      };
}
