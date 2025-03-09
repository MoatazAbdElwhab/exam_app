// core/database/question_model.dart

import 'package:hive/hive.dart';

part 'question_model.g.dart';

@HiveType(typeId: 0)
class QuestionModel {

  @HiveField(0)
  final dynamic id;

  @HiveField(1)
  final dynamic examID;

  @HiveField(2)
  final dynamic questionID;

  @HiveField(3)
  final dynamic question;

  @HiveField(4)
  final dynamic answes;

  @HiveField(5)
  final dynamic correctAnswer;

  @HiveField(6)
  final dynamic userAnswer;

  @HiveField(7)
  final dynamic duration;

  @HiveField(8)
  final bool isCompleted;

  QuestionModel({
    required this.id,
    required this.examID,
    required this.questionID,
    required this.question,
    required this.answes,
    required this.correctAnswer,
    required this.userAnswer,
    required this.duration,
    required this.isCompleted,
  });
}
