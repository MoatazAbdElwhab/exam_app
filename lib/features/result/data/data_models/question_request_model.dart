// features/result/data/data_models/question_request_model.dart
import 'package:exam_app/features/result/data/data_models/model.dart';
import 'package:exam_app/features/result/domain/entities/question_request.dart';

class QuestionRequestModel extends QuestionRequest {
  final String? id;
  final String? question;
  final List<AnswerModel>? answers;
  final String? type;
  final String? correct;
  final Map<String, dynamic>? subject;
  final Map<String, dynamic>? exam;
  final String? createdAt;
  final String? selectedAnswer;

  QuestionRequestModel({
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

  factory QuestionRequestModel.fromJson(Map<String, dynamic> json) =>
      QuestionRequestModel(
        id: json['_id'],
        question: json['question'],
        answers: (json['answers'] as List<dynamic>?)
            ?.map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        type: json['type'],
        correct: json['correct'],
        subject: json['subject'] as Map<String, dynamic>?,
        exam: json['exam'] as Map<String, dynamic>?,
        createdAt: json['createdAt'],
        selectedAnswer: json['selectedAnswer'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'question': question,
        'answers': answers?.map((e) => (e as AnswerModel).toJson()).toList(),
        'type': type,
        'correct': correct,
        'subject': subject,
        'exam': exam,
        'createdAt': createdAt,
        'selectedAnswer': selectedAnswer,
      };

  QuestionRequestModel copyWith({
    String? id,
    String? question,
    List<AnswerModel>? answers,
    String? type,
    String? correct,
    Map<String, dynamic>? subject,
    Map<String, dynamic>? exam,
    String? createdAt,
    String? selectedAnswer,
  }) {
    return QuestionRequestModel(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      type: type ?? this.type,
      correct: correct ?? this.correct,
      subject: subject ?? this.subject,
      exam: exam ?? this.exam,
      createdAt: createdAt ?? this.createdAt,
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
    );
  }
}