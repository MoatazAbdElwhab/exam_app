import 'package:exam_app/core/app_data/api/api_constants.dart';
import 'package:exam_app/features/explore/data/models/answers_model/select_answer_model.dart';

class SelectAnswersModel {
  final List<SelectAnswerModel> answers;
  final int time;

  const SelectAnswersModel({
    required this.answers,
    required this.time,
  });

  factory SelectAnswersModel.fromJson(Map<String, dynamic> json) =>
      SelectAnswersModel(
        answers: (json[ApiConstants.answersKey] as List<dynamic>)
            .map((e) => SelectAnswerModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        time: json[ApiConstants.timeKey] as int,
      );

  Map<String, dynamic> toJson() => {
        ApiConstants.answersKey: answers.map((e) => e.toJson()).toList(),
        ApiConstants.timeKey: time,
      };

  SelectAnswersModel copyWith({
    List<SelectAnswerModel>? answers,
    int? time,
  }) {
    return SelectAnswersModel(
      answers: answers ?? this.answers,
      time: time ?? this.time,
    );
  }
}
