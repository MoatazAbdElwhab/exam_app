// features/result/data/data_models/wrong_question_model.dart

// features/result/data/models/wrong_question_model.dart
import 'package:exam_app/features/result/domain/entities/answers.dart';

import '../../domain/entities/wrong_question.dart';
import 'answers_model.dart';

class WrongQuestionModel extends WrongQuestion {
  WrongQuestionModel({
    super.qid,
    super.question,
    super.inCorrectAnswer,
    super.correctAnswer,
    super.answers,
  });

  factory WrongQuestionModel.fromJson(Map<String, dynamic> json) =>
      WrongQuestionModel(
        qid: json['QID'],
        question: json['Question'],
        inCorrectAnswer: json['inCorrectAnswer'],
        correctAnswer: json['correctAnswer'],
        answers: json['answers'] == null
            ? null
            : AnswersModel.fromJson(json['answers'] as Map<String, dynamic>)
                as Answers?,
      );

  Map<String, dynamic> toJson() => {
        'QID': qid,
        'Question': question,
        'inCorrectAnswer': inCorrectAnswer,
        'correctAnswer': correctAnswer,
        'answers': (answers as AnswersModel?)?.toJson(),
      };
}
