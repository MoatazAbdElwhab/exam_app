// features/result/data/data_models/question_request_model.dart

class QuestionRequestModel {
  final String? id;
  final String? question;
  final List<AnswerModel>? answers;
  final String? type;
  final String? correct;
  final SubjectModel? subject;
  final ExamModel? exam;
  final String? createdAt;
  final String? selectedAnswer;

  const QuestionRequestModel({
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

  factory QuestionRequestModel.fromJson(Map<String, dynamic> json) {
    return QuestionRequestModel(
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
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'question': question,
      'answers': answers?.map((e) => e.toJson()).toList(),
      'type': type,
      'correct': correct,
      'subject': subject?.toJson(),
      'exam': exam?.toJson(),
      'createdAt': createdAt,
      'selectedAnswer': selectedAnswer,
    };
  }
}

class SubjectModel {
  final String? id;
  final String? name;
  final String? icon;
  final String? createdAt;

  const SubjectModel({
    this.id,
    this.name,
    this.icon,
    this.createdAt,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      icon: json['icon'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'icon': icon,
      'createdAt': createdAt,
    };
  }
}

class ExamModel {
  final String? id;
  final String? title;
  final int? duration;
  final String? subject;
  final int? numberOfQuestions;
  final bool? active;
  final String? createdAt;

  const ExamModel({
    this.id,
    this.title,
    this.duration,
    this.subject,
    this.numberOfQuestions,
    this.active,
    this.createdAt,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) {
    return ExamModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      duration: json['duration'] as int?,
      subject: json['subject'] as String?,
      numberOfQuestions: json['numberOfQuestions'] as int?,
      active: json['active'] as bool?,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'duration': duration,
      'subject': subject,
      'numberOfQuestions': numberOfQuestions,
      'active': active,
      'createdAt': createdAt,
    };
  }
}

class AnswerModel {
  final String? key;
  final String? answer;

  const AnswerModel({
    this.key,
    this.answer,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) {
    return AnswerModel(
      key: json['key'] as String?,
      answer: json['answer'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'answer': answer,
    };
  }
}