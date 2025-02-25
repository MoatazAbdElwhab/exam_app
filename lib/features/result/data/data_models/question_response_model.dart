// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class QuestionResponseModel extends Equatable {
  final String message;
  final List<QuestionModel> questions;

  const QuestionResponseModel({
    required this.message,
    required this.questions,
  });

  factory QuestionResponseModel.fromJson(Map<String, dynamic> json) {
    return QuestionResponseModel(
      message: json['message'] as String,
      questions: (json['questions'] as List)
          .map((e) => QuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [message, questions];
}

class QuestionModel extends Equatable {
  final List<AnswerModel> answers;
  final String type;
  final String id;
  final String question;
  final String correct;
  final SubjectModel subject;
  final ExamModel exam;
  final String createdAt;

  const QuestionModel({
    required this.answers,
    required this.type,
    required this.id,
    required this.question,
    required this.correct,
    required this.subject,
    required this.exam,
    required this.createdAt,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      answers: (json['answers'] as List)
          .map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String,
      id: json['_id'] as String,
      question: json['question'] as String,
      correct: json['correct'] as String,
      subject: SubjectModel.fromJson(json['subject'] as Map<String, dynamic>),
      exam: ExamModel.fromJson(json['exam'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String,
    );
  }

  @override
  List<Object?> get props => [
        answers,
        type,
        id,
        question,
        correct,
        subject,
        exam,
        createdAt,
      ];
}

class AnswerModel extends Equatable {
  final String answer;
  final String key;

  const AnswerModel({
    required this.answer,
    required this.key,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      answer: json['answer'] as String,
      key: json['key'] as String,
    );
  }

  @override
  List<Object?> get props => [answer, key];
}

class SubjectModel extends Equatable {
  final String id;
  final String name;
  final String icon;
  final String createdAt;

  const SubjectModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.createdAt,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      icon: json['icon'] as String,
      createdAt: json['createdAt'] as String,
    );
  }

  @override
  List<Object?> get props => [id, name, icon, createdAt];
}

class ExamModel extends Equatable {
  final String id;
  final String title;
  final int duration;
  final String subject;
  final int numberOfQuestions;
  final bool active;
  final String createdAt;

  const ExamModel({
    required this.id,
    required this.title,
    required this.duration,
    required this.subject,
    required this.numberOfQuestions,
    required this.active,
    required this.createdAt,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['_id'] as String,
      title: json['title'] as String,
      duration: json['duration'] as int,
      subject: json['subject'] as String,
      numberOfQuestions: json['numberOfQuestions'] as int,
      active: json['active'] as bool,
      createdAt: json['createdAt'] as String,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        duration,
        subject,
        numberOfQuestions,
        active,
        createdAt,
      ];
}
