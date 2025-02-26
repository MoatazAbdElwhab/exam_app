import 'package:exam_app/core/app_data/api/api_constants.dart';

class ExamModel {
  final String id;
  final String title;
  final int duration;
  final String subject;
  final int numberOfQuestions;
  final bool active;
  final DateTime createdAt;

  const ExamModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.subject,
    required this.numberOfQuestions,
    required this.active,
    required this.createdAt,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        id: json[ApiConstants.idKey] as String,
        title: json[ApiConstants.titleKey] as String,
        duration: json[ApiConstants.durationKey] as int,
        subject: json[ApiConstants.subjectKey] as String,
        numberOfQuestions: json[ApiConstants.numberOfQuestionsKey] as int,
        active: json[ApiConstants.activeKey] as bool,
        createdAt: DateTime.parse(json[ApiConstants.createdAtKey] as String),
      );

  Map<String, dynamic> toJson() => {
        ApiConstants.idKey: id,
        ApiConstants.titleKey: title,
        ApiConstants.durationKey: duration,
        ApiConstants.subjectKey: subject,
        ApiConstants.numberOfQuestionsKey: numberOfQuestions,
        ApiConstants.activeKey: active,
        ApiConstants.createdAtKey: createdAt.toIso8601String(),
      };
}
