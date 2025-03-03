// features/result/data/data_models/result_response_model.dart

import 'package:exam_app/features/result/data/data_models/answer_model.dart';

class ResultResponseModel {
  final String? message;
  final int? correct;
  final int? wrong;
  final String? total;
  final List<WrongQuestionModel>? wrongQuestions;
  final List<WrongQuestionModel>? correctQuestions;

  const ResultResponseModel({
    this.message,
    this.correct,
    this.wrong,
    this.total,
    this.wrongQuestions,
    this.correctQuestions,
  });

  factory ResultResponseModel.fromJson(Map<String, dynamic> json) {
    return ResultResponseModel(
      message: json['message'] as String?,
      correct: json['correct'] as int?,
      wrong: json['wrong'] as int?,
      total: json['total'] as String?,
      wrongQuestions: (json['wrongQuestions'] as List<dynamic>?)
          ?.map((e) => WrongQuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      correctQuestions: (json['correctQuestions'] as List<dynamic>?)
          ?.map((e) => WrongQuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'correct': correct,
      'wrong': wrong,
      'total': total,
      'wrongQuestions': wrongQuestions?.map((e) => e.toJson()).toList(),
      'correctQuestions': correctQuestions?.map((e) => e.toJson()).toList(),
    };
  }
}

class WrongQuestionModel {
  final String? id;
  final String? question;
  final String? type;
  final List<AnswerModel>? answers;
  final String? selectedAnswer;
  final String? correctAnswer;
  final Map<String, dynamic>? subject;
  final Map<String, dynamic>? exam;
  final String? createdAt;

  const WrongQuestionModel({
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

  factory WrongQuestionModel.fromJson(Map<String, dynamic> json) {
    return WrongQuestionModel(
      id: json['_id'] as String?,
      question: json['question'] as String?,
      type: json['type'] as String?,
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      selectedAnswer: json['selectedAnswer'] as String?,
      correctAnswer: json['correctAnswer'] as String?,
      subject: json['subject'] as Map<String, dynamic>?,
      exam: json['exam'] as Map<String, dynamic>?,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'question': question,
      'type': type,
      'answers': answers?.map((e) => e.toJson()).toList(),
      'selectedAnswer': selectedAnswer,
      'correctAnswer': correctAnswer,
      'subject': subject,
      'exam': exam,
      'createdAt': createdAt,
    };
  }
}
