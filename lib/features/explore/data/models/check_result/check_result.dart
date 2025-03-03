import 'package:exam_app/features/explore/data/models/check_result/correct_question.dart';
import 'package:exam_app/features/explore/data/models/check_result/wrong_question.dart';

class CheckResult {
  final String? message;
  final int? correct;
  final int? wrong;
  final String? total;
  final List<WrongQuestion>? wrongQuestions;
  final List<CorrectQuestion>? correctQuestions;

  const CheckResult({
    this.message,
    this.correct,
    this.wrong,
    this.total,
    this.wrongQuestions,
    this.correctQuestions,
  });

  factory CheckResult.fromJson(Map<String, dynamic> json) => CheckResult(
        message: json['message'] as String?,
        correct: json['correct'] as int?,
        wrong: json['wrong'] as int?,
        total: json['total'] as String?,
        wrongQuestions: (json['WrongQuestions'] as List<dynamic>?)
            ?.map((e) => WrongQuestion.fromJson(e as Map<String, dynamic>))
            .toList(),
        correctQuestions: (json['correctQuestions'] as List<dynamic>?)
            ?.map((e) => CorrectQuestion.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'correct': correct,
        'wrong': wrong,
        'total': total,
        'WrongQuestions': wrongQuestions?.map((e) => e.toJson()).toList(),
        'correctQuestions': correctQuestions?.map((e) => e.toJson()).toList(),
      };
}
