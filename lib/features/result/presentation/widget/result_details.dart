import 'package:flutter/material.dart';

class ResultDetails extends StatelessWidget {
  final String question;
  final List<String> options;
  final int selectedAnswerIndex;
  final int correctAnswerIndex;

  const ResultDetails({
    Key? key,
    required this.question,
    required this.options,
    required this.selectedAnswerIndex,
    required this.correctAnswerIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
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
            question,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          ...List.generate(
            options.length,
            (index) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _getOptionColor(index),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  _getOptionIcon(index),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      options[index],
                      style: TextStyle(
                        color: _getTextColor(index),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getOptionColor(int index) {
    if (index == correctAnswerIndex) {
      return Colors.green.withOpacity(0.1);
    }
    if (index == selectedAnswerIndex && selectedAnswerIndex != correctAnswerIndex) {
      return Colors.red.withOpacity(0.1);
    }
    return Colors.grey.withOpacity(0.1);
  }

  Color _getTextColor(int index) {
    if (index == correctAnswerIndex) {
      return Colors.green;
    }
    if (index == selectedAnswerIndex && selectedAnswerIndex != correctAnswerIndex) {
      return Colors.red;
    }
    return Colors.black87;
  }

  Widget _getOptionIcon(int index) {
    if (index == correctAnswerIndex) {
      return const Icon(Icons.check_circle, color: Colors.green, size: 20);
    }
    if (index == selectedAnswerIndex && selectedAnswerIndex != correctAnswerIndex) {
      return const Icon(Icons.cancel, color: Colors.red, size: 20);
    }
    return const Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 20);
  }
}
