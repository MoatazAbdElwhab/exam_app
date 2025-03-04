// features/result/presentation/widget/exam_answer_option.dart
import 'package:flutter/material.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';

class ExamAnswerOption extends StatelessWidget {
  final String answer;
  final bool isCorrect;
  final bool isUserAnswer;

  const ExamAnswerOption({
    super.key,
    required this.answer,
    required this.isCorrect,
    required this.isUserAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(
            _getIcon(),
            color: _getColor(),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              answer,
              style: getMediumStyle(
                color: _getColor(),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    if (isCorrect) return Colors.green.withOpacity(0.1);
    if (isUserAnswer && !isCorrect) return Colors.red.withOpacity(0.1);
    return Colors.grey.withOpacity(0.1);
  }

  Color _getColor() {
    if (isCorrect) return Colors.green;
    if (isUserAnswer && !isCorrect) return Colors.red;
    return ColorManager.black;
  }

  IconData _getIcon() {
    if (isCorrect) return Icons.check_circle;
    if (isUserAnswer && !isCorrect) return Icons.cancel;
    return Icons.radio_button_unchecked;
  }
}
