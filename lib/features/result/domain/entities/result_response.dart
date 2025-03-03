// features/result/domain/entities/result_response.dart

// features/result/domain/entities/result_response.dart
import 'package:exam_app/features/result/domain/entities/wrong_question.dart';

class ResultResponse {
  final String? message;
  final int? correct;
  final int? wrong;
  final String? total;
  final List<WrongQuestion>? wrongQuestions;
  final List<dynamic>? correctQuestions;

  ResultResponse({
    this.message,
    this.correct,
    this.wrong,
    this.total,
    this.wrongQuestions,
    this.correctQuestions,
  });
}