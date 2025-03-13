// features/result/presentation/widget/exam_question_card.dart
import 'package:flutter/material.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:exam_app/features/result/presentation/widget/exam_answer_option.dart';

class ExamQuestionCard extends StatelessWidget {
  final QuestionModelHive question;

  const ExamQuestionCard({
    super.key,
    required this.question,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> answers = question.answes;
    final String? userAnswer = question.userAnswer;
    final String correctAnswer = question.correctAnswer;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorManager.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Q${question.questionID}. ${question.question}',
            style: getBoldStyle(
              color: ColorManager.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          ...List<Widget>.generate(
            answers.length,
            (index) {
              final String answer = answers[index];
              final String answerKey = 'A${index + 1}';
              final bool isCorrect = answerKey == correctAnswer;
              final bool isSelected = userAnswer != null && answerKey == userAnswer;

              return ExamAnswerOption(
                answer: answer,
                isCorrect: isCorrect,
                isUserAnswer: isSelected,
              );
            },
          ),
        ],
      ),
    );
  }
}
