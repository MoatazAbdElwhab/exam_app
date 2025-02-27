// features/result/data/data_models/wrong_question_model.dart

import 'package:exam_app/features/result/data/data_models/model.dart';

import '../../domain/entities/wrong_question.dart';

class WrongQuestionModel extends WrongQuestion {
  WrongQuestionModel({
    super.id,
    super.question,
    super.type,
    super.answers,
    super.selectedAnswer,
    super.correctAnswer,
    super.subject,
    super.exam,
    super.createdAt,
  });

  factory WrongQuestionModel.fromJson(Map<String, dynamic> json) =>
      WrongQuestionModel(
        id: json['_id'],
        question: json['question'],
        type: json['type'],
        answers: (json['answers'] as List<dynamic>?)
            ?.map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        selectedAnswer: json['selectedAnswer'],
        correctAnswer: json['correct'],
        subject: json['subject'] as Map<String, dynamic>?,
        exam: json['exam'] as Map<String, dynamic>?,
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'question': question,
        'type': type,
        'answers': answers?.map((e) => (e as AnswerModel).toJson()).toList(),
        'selectedAnswer': selectedAnswer,
        'correct': correctAnswer,
        'subject': subject,
        'exam': exam,
        'createdAt': createdAt,
      };
}