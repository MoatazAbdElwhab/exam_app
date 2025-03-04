import 'package:flutter/material.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/result/presentation/widget/result_container.dart';

class ExamGroupItem extends StatelessWidget {
  final List<QuestionRequestModel> examQuestions;
  final Map<String, UserQuestionData> userAnswers;
  final int index;

  const ExamGroupItem({
    super.key,
    required this.examQuestions,
    required this.userAnswers,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final firstQuestion = examQuestions.first;
    final stats = _calculateExamStats();

    return ResultContainer(
      context: context,
      question: firstQuestion,
      userAnswer: userAnswers[firstQuestion.id],
      index: index,
      totalQuestions: stats.totalQuestions,
      correctAnswers: stats.correctAnswers,
      timeSpent: firstQuestion.exam?.duration ?? 0,
      examQuestions: examQuestions,
      userAnswers: userAnswers,
    );
  }

  ExamStats _calculateExamStats() {
    int correctAnswers = 0;
    for (var question in examQuestions) {
      if (question.id != null &&
          userAnswers[question.id]?.userAnswer == question.correct) {
        correctAnswers++;
      }
    }
    return ExamStats(
      totalQuestions: examQuestions.length,
      correctAnswers: correctAnswers,
    );
  }
}

class ExamStats {
  final int totalQuestions;
  final int correctAnswers;

  const ExamStats({
    required this.totalQuestions,
    required this.correctAnswers,
  });
}
