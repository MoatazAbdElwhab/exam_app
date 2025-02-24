// features/result/domain/entities/wrong_question.dart
import 'package:exam_app/features/result/domain/entities/answers.dart';

class WrongQuestion {
  final String? qid;
  final String? question;
  final String? inCorrectAnswer;
  final String? correctAnswer;
  final Answers? answers;

  WrongQuestion({
    this.qid,
    this.question,
    this.inCorrectAnswer,
    this.correctAnswer,
    this.answers,
  });
}