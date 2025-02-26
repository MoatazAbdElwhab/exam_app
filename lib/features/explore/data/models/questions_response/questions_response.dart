import 'package:exam_app/core/app_data/api/api_constants.dart';
import 'package:exam_app/features/explore/data/models/questions_response/question_model.dart';

class QuestionsResponse {
  final String message;
  final List<QuestionModel> questions;

  const QuestionsResponse({
    required this.message,
    required this.questions,
  });

  factory QuestionsResponse.fromJson(Map<String, dynamic> json) {
    return QuestionsResponse(
      message: json[ApiConstants.messageKey] as String,
      questions: (json[ApiConstants.questionsKey] as List<dynamic>)
          .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        ApiConstants.messageKey: message,
        ApiConstants.questionsKey: questions.map((e) => e.toJson()).toList(),
      };
}
