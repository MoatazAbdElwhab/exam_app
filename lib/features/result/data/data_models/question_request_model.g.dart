// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$QuestionRequestModelImpl _$$QuestionRequestModelImplFromJson(
        Map<String, dynamic> json) =>
    _$QuestionRequestModelImpl(
      id: json['_id'] as String?,
      question: json['question'] as String?,
      answers: (json['answers'] as List<dynamic>?)
          ?.map((e) => AnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      type: json['type'] as String?,
      correct: json['correct'] as String?,
      subject: json['subject'] == null
          ? null
          : SubjectModel.fromJson(json['subject'] as Map<String, dynamic>),
      exam: json['exam'] == null
          ? null
          : ExamModel.fromJson(json['exam'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      selectedAnswer: json['selectedAnswer'] as String?,
    );

Map<String, dynamic> _$$QuestionRequestModelImplToJson(
        _$QuestionRequestModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'question': instance.question,
      'answers': instance.answers,
      'type': instance.type,
      'correct': instance.correct,
      'subject': instance.subject,
      'exam': instance.exam,
      'createdAt': instance.createdAt,
      'selectedAnswer': instance.selectedAnswer,
    };

_$SubjectModelImpl _$$SubjectModelImplFromJson(Map<String, dynamic> json) =>
    _$SubjectModelImpl(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$$SubjectModelImplToJson(_$SubjectModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'createdAt': instance.createdAt,
    };

_$ExamModelImpl _$$ExamModelImplFromJson(Map<String, dynamic> json) =>
    _$ExamModelImpl(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      subject: json['subject'] as String?,
      numberOfQuestions: (json['numberOfQuestions'] as num?)?.toInt(),
      active: json['active'] as bool?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$$ExamModelImplToJson(_$ExamModelImpl instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'duration': instance.duration,
      'subject': instance.subject,
      'numberOfQuestions': instance.numberOfQuestions,
      'active': instance.active,
      'createdAt': instance.createdAt,
    };

_$AnswerModelImpl _$$AnswerModelImplFromJson(Map<String, dynamic> json) =>
    _$AnswerModelImpl(
      answer: json['answer'] as String?,
      key: json['key'] as String?,
    );

Map<String, dynamic> _$$AnswerModelImplToJson(_$AnswerModelImpl instance) =>
    <String, dynamic>{
      'answer': instance.answer,
      'key': instance.key,
    };
