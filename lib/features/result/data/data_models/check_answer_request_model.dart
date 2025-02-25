// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CheckAnswerRequestModel extends Equatable {
  final List<AnswerSubmission> answers;
  final int time;

  const CheckAnswerRequestModel({
    required this.answers,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'answers': answers.map((e) => e.toJson()).toList(),
      'time': time,
    };
  }

  @override
  List<Object?> get props => [answers, time];
}

class AnswerSubmission extends Equatable {
  final String questionId;
  final String correct;

  const AnswerSubmission({
    required this.questionId,
    required this.correct,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'correct': correct,
    };
  }

  @override
  List<Object?> get props => [questionId, correct];
}
