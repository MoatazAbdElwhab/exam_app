// features/result/domain/entities/question_request.dart

import 'package:exam_app/features/result/domain/entities/answer.dart';

class QuestionRequest {
  final String? id;
  final String? question;
  final List<Answer>? answers;
  final String? type;
  final String? correct;
  final Map<String, dynamic>? subject;
  final Map<String, dynamic>? exam;
  final String? createdAt;
  final String? selectedAnswer;

  QuestionRequest({
    this.id,
    this.question,
    this.answers,
    this.type,
    this.correct,
    this.subject,
    this.exam,
    this.createdAt,
    this.selectedAnswer,
  });
}