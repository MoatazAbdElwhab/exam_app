// features/result/presentation/widget/result_details.dart

import 'package:flutter/material.dart';
import 'package:exam_app/features/result/presentation/widget/question_card.dart';
import 'package:exam_app/features/result/presentation/widget/question_option.dart';

class ResultDetailsWidget extends StatelessWidget {
  final String question;
  final List<String> options;
  final int selectedAnswerIndex;
  final int correctAnswerIndex;

  const ResultDetailsWidget({
    Key? key,
    required this.question,
    required this.options,
    required this.selectedAnswerIndex,
    required this.correctAnswerIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(
            options.length,
            (index) => QuestionOption(
              option: options[index],
              index: index,
              selectedAnswerIndex: selectedAnswerIndex,
              correctAnswerIndex: correctAnswerIndex,
            ),
          ),
        ],
      ),
    );
  }
}
