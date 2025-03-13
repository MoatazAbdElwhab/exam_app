// features/result/data/data_models/hive_model/question_model.dart

import 'package:hive/hive.dart';

part 'question_model.g.dart';

@HiveType(typeId: 0)
class QuestionModelHive extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String examID;

  @HiveField(2)
  final String questionID;

  @HiveField(3)
  final String question;

  @HiveField(4)
  final List<String> answes; 

  @HiveField(5)
  final String correctAnswer;

  @HiveField(6)
  final String? userAnswer;

  @HiveField(7)
  final int duration;

  @HiveField(8)
  final bool isCompleted;



  QuestionModelHive({
    required this.id,
    required this.examID,
    required this.questionID,
    required this.question,
    required this.answes,
    required this.correctAnswer,
    required this.duration,
    required this.isCompleted,
    this.userAnswer,
  });
}
