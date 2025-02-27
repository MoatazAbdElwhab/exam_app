// features/result/data/data_models/history_response_model.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class HistoryResponseModel extends Equatable {
  final String? message;
  final HistoryData? history;

  const HistoryResponseModel({
    this.message,
    this.history,
  });

  factory HistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      HistoryResponseModel(
        message: json['message'],
        history: json['history'] != null
            ? HistoryData.fromJson(json['history'])
            : null,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [message, history];
}

class HistoryData {
  final String? id;
  final String? checkAnswer;
  final QuestionData? qid;
  final String? user;
  final String? chosenAnswer;
  final String? avgAnswerTime;
  final String? createdAt;

  HistoryData({
    this.id,
    this.checkAnswer,
    this.qid,
    this.user,
    this.chosenAnswer,
    this.avgAnswerTime,
    this.createdAt,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) => HistoryData(
        id: json['_id'],
        checkAnswer: json['checkAnswer'],
        qid: json['QID'] != null ? QuestionData.fromJson(json['QID']) : null,
        user: json['user'],
        chosenAnswer: json['chosenAnswer'],
        avgAnswerTime: json['avgAnswerTime'],
        createdAt: json['createdAt'],
      );
}

class QuestionData {
  final List<AnswerData>? answers;
  final String? type;
  final String? id;
  final String? question;
  final String? correct;
  final String? subject;
  final String? exam;
  final String? createdAt;

  QuestionData({
    this.answers,
    this.type,
    this.id,
    this.question,
    this.correct,
    this.subject,
    this.exam,
    this.createdAt,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) => QuestionData(
        answers: (json['answers'] as List<dynamic>?)
            ?.map((e) => AnswerData.fromJson(e))
            .toList(),
        type: json['type'],
        id: json['_id'],
        question: json['question'],
        correct: json['correct'],
        subject: json['subject'],
        exam: json['exam'],
        createdAt: json['createdAt'],
      );
}

class AnswerData {
  final String? answer;
  final String? key;

  AnswerData({this.answer, this.key});

  factory AnswerData.fromJson(Map<String, dynamic> json) => AnswerData(
        answer: json['answer'],
        key: json['key'],
      );
}
