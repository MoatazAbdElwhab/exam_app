// features/result/domain/entities/wrong_question.dart
import 'package:exam_app/features/result/domain/entities/answer.dart';

class WrongQuestion {
  final String? id;
  final String? question;
  final String? type;
  final List<Answer>? answers;
  final String? selectedAnswer;
  final String? correctAnswer;
  final Map<String, dynamic>? subject;
  final Map<String, dynamic>? exam;
  final String? createdAt;

  WrongQuestion({
    this.id,
    this.question,
    this.type,
    this.answers,
    this.selectedAnswer,
    this.correctAnswer,
    this.subject,
    this.exam,
    this.createdAt,
  });
}