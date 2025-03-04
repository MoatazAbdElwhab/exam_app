// features/result/presentation/widget/exam_question_card.dart
import 'package:flutter/material.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/result/presentation/widget/exam_answer_option.dart';

class ExamQuestionCard extends StatelessWidget {
  final QuestionRequestModel question;
  final UserQuestionData? userAnswer;

  const ExamQuestionCard({
    super.key,
    required this.question,
    required this.userAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question ?? '',
            style: getBoldStyle(
              color: ColorManager.black,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          ...question.answers.map((answer) {
            final isCorrect = answer.key == question.correct;
            final isUserAnswer = userAnswer?.userAnswer == answer.key;

            return ExamAnswerOption(
              answer: answer.answer ?? '',
              isCorrect: isCorrect,
              isUserAnswer: isUserAnswer,
            );
          }),
        ],
      ),
    );
  }
}
