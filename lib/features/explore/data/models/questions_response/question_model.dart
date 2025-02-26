import 'package:exam_app/core/app_data/api/api_constants.dart';
import 'package:exam_app/features/explore/data/models/questions_response/answer_model.dart';

class QuestionModel {
  final List<AnswerModel> answers;
  final String type;
  final String id;
  final String question;
  final String correct;
  final DateTime createdAt;

  const QuestionModel({
    required this.answers,
    required this.type,
    required this.id,
    required this.question,
    required this.correct,
    required this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        answers: (json[ApiConstants.answersKey] as List<dynamic>)
            .map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        type: json[ApiConstants.typeKey] as String,
        id: json[ApiConstants.idKey] as String,
        question: json[ApiConstants.questionKey] as String,
        correct: json[ApiConstants.correctKey] as String,
        createdAt: DateTime.parse(json[ApiConstants.createdAtKey] as String),
      );

  Map<String, dynamic> toJson() => {
        ApiConstants.answersKey: answers.map((e) => e.toJson()).toList(),
        ApiConstants.typeKey: type,
        ApiConstants.idKey: id,
        ApiConstants.questionKey: question,
        ApiConstants.correctKey: correct,
        ApiConstants.createdAtKey: createdAt.toIso8601String(),
      };
}
