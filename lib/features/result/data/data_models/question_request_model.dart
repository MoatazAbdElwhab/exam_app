// features/result/data/data_models/question_request_model.dart

import 'package:freezed_annotation/freezed_annotation.dart';

part 'question_request_model.freezed.dart';
part 'question_request_model.g.dart';

@freezed
class QuestionRequestModel with _$QuestionRequestModel {
  const factory QuestionRequestModel({
    @JsonKey(name: '_id') String? id,
    String? question,
    List<AnswerModel>? answers,
    String? type,
    String? correct,
    SubjectModel? subject,
    ExamModel? exam,
    String? createdAt,
    String? selectedAnswer,
  }) = _QuestionRequestModel;

  factory QuestionRequestModel.fromJson(Map<String, dynamic> json) =>
      _$QuestionRequestModelFromJson(json);
}

@freezed
class SubjectModel with _$SubjectModel {
  const factory SubjectModel({
    @JsonKey(name: '_id') String? id,
    String? name,
    String? icon,
    String? createdAt,
  }) = _SubjectModel;

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);
}

@freezed
class ExamModel with _$ExamModel {
  const factory ExamModel({
    @JsonKey(name: '_id') String? id,
    String? title,
    int? duration,
    String? subject,
    int? numberOfQuestions,
    bool? active,
    String? createdAt,
  }) = _ExamModel;

  factory ExamModel.fromJson(Map<String, dynamic> json) =>
      _$ExamModelFromJson(json);
}

@freezed
class AnswerModel with _$AnswerModel {
  const factory AnswerModel({
    String? answer,
    String? key,
  }) = _AnswerModel;

  factory AnswerModel.fromJson(Map<String, dynamic> json) =>
      _$AnswerModelFromJson(json);
}