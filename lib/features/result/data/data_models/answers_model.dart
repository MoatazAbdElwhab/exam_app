// features/result/data/data_models/answers_model.dart
import '../../domain/entities/answers.dart';

class AnswersModel extends Answers {
  AnswersModel();

  factory AnswersModel.fromJson(Map<String, dynamic> json) => AnswersModel();

  Map<String, dynamic> toJson() => {};
}