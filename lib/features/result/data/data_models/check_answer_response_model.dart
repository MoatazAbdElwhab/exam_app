// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CheckAnswerResponseModel extends Equatable {
  final String message;
  final int correct;
  final int wrong;
  final String total;
  final List<WrongQuestionModel> wrongQuestions;
  final List<CorrectQuestionModel> correctQuestions;

  const CheckAnswerResponseModel({
    required this.message,
    required this.correct,
    required this.wrong,
    required this.total,
    required this.wrongQuestions,
    required this.correctQuestions,
  });

  factory CheckAnswerResponseModel.fromJson(Map<String, dynamic> json) {
    return CheckAnswerResponseModel(
      message: json['message'] as String,
      correct: json['correct'] as int,
      wrong: json['wrong'] as int,
      total: json['total'] as String,
      wrongQuestions: (json['WrongQuestions'] as List)
          .map((e) => WrongQuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      correctQuestions: (json['correctQuestions'] as List)
          .map((e) => CorrectQuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
        message,
        correct,
        wrong,
        total,
        wrongQuestions,
        correctQuestions,
      ];
}

class WrongQuestionModel extends Equatable {
  final String qid;
  final String question;
  final String incorrectAnswer;
  final String correctAnswer;
  final Map<String, dynamic> answers;

  const WrongQuestionModel({
    required this.qid,
    required this.question,
    required this.incorrectAnswer,
    required this.correctAnswer,
    required this.answers,
  });

  factory WrongQuestionModel.fromJson(Map<String, dynamic> json) {
    return WrongQuestionModel(
      qid: json['QID'] as String,
      question: json['Question'] as String,
      incorrectAnswer: json['inCorrectAnswer'] as String,
      correctAnswer: json['correctAnswer'] as String,
      answers: json['answers'] as Map<String, dynamic>,
    );
  }

  @override
  List<Object?> get props => [
        qid,
        question,
        incorrectAnswer,
        correctAnswer,
        answers,
      ];
}

class CorrectQuestionModel extends Equatable {
  final String qid;
  final String question;
  final String correctAnswer;
  final Map<String, dynamic> answers;

  const CorrectQuestionModel({
    required this.qid,
    required this.question,
    required this.correctAnswer,
    required this.answers,
  });

  factory CorrectQuestionModel.fromJson(Map<String, dynamic> json) {
    return CorrectQuestionModel(
      qid: json['QID'] as String,
      question: json['Question'] as String,
      correctAnswer: json['correctAnswer'] as String,
      answers: json['answers'] as Map<String, dynamic>,
    );
  }

  @override
  List<Object?> get props => [
        qid,
        question,
        correctAnswer,
        answers,
      ];
}
