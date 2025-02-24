// features/result/domain/entities/question_request.dart

import 'package:exam_app/features/result/domain/entities/answer.dart';

class QuestionRequest {
  final List<Answer>? answers;
  final int? time;

  QuestionRequest({this.answers, this.time});
}