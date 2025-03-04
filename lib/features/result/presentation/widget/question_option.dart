import 'package:flutter/material.dart';

class QuestionOption extends StatelessWidget {
  final String option;
  final int index;
  final int selectedAnswerIndex;
  final int correctAnswerIndex;

  const QuestionOption({
    super.key,
    required this.option,
    required this.index,
    required this.selectedAnswerIndex,
    required this.correctAnswerIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getOptionColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildOptionIcon(),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              option,
              style: TextStyle(
                color: _getTextColor(),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getOptionColor() {
    if (index == correctAnswerIndex) {
      return Colors.green.withOpacity(0.1);
    }
    if (index == selectedAnswerIndex && selectedAnswerIndex != correctAnswerIndex) {
      return Colors.red.withOpacity(0.1);
    }
    return Colors.grey.withOpacity(0.1);
  }

  Color _getTextColor() {
    if (index == correctAnswerIndex) {
      return Colors.green;
    }
    if (index == selectedAnswerIndex && selectedAnswerIndex != correctAnswerIndex) {
      return Colors.red;
    }
    return Colors.black87;
  }

  Widget _buildOptionIcon() {
    if (index == correctAnswerIndex) {
      return const Icon(Icons.check_circle, color: Colors.green, size: 20);
    }
    if (index == selectedAnswerIndex && selectedAnswerIndex != correctAnswerIndex) {
      return const Icon(Icons.cancel, color: Colors.red, size: 20);
    }
    return const Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 20);
  }
}
