// features/result/data/data_models/question_request_model.dart
import 'package:exam_app/features/result/data/data_models/model.dart';
import 'package:exam_app/features/result/domain/entities/question_request.dart';

class QuestionRequestModel extends QuestionRequest {
  QuestionRequestModel({super.answers, super.time});

  factory QuestionRequestModel.fromJson(Map<String, dynamic> json) =>
      QuestionRequestModel(
        answers: (json['answers'] as List<dynamic>?)
            ?.map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        time: json['time'],
      );

  Map<String, dynamic> toJson() => {
        'answers': answers?.map((e) => (e as AnswerModel).toJson()).toList(),
        'time': time,
      };
}