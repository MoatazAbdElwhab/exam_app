import 'package:exam_app/core/app_data/api/api_constants.dart';

class SelectAnswerModel {
  final String questionId;
  final String correct;

  const SelectAnswerModel({
    required this.questionId,
    required this.correct,
  });

  factory SelectAnswerModel.fromJson(Map<String, dynamic> json) =>
      SelectAnswerModel(
        questionId: json[ApiConstants.questionIdKey] as String,
        correct: json[ApiConstants.correctKey] as String,
      );

  Map<String, dynamic> toJson() => {
        ApiConstants.questionIdKey: questionId,
        ApiConstants.correctKey: correct,
      };

  SelectAnswerModel copyWith({
    String? questionId,
    String? correct,
  }) {
    return SelectAnswerModel(
      questionId: questionId ?? this.questionId,
      correct: correct ?? this.correct,
    );
  }
}
