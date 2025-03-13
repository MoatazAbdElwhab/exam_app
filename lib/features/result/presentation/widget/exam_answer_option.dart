// features/result/presentation/widget/exam_answer_option.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

enum AnswerStatus {
  correct,
  incorrect,
  unselected
}

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

  AnswerStatus get _status {
    if (isCorrect) return AnswerStatus.correct;
    if (isUserAnswer) return AnswerStatus.incorrect;
    return AnswerStatus.unselected;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildAnswerIcon(),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              answer,
              style: getRegularStyle(
                color: ColorManager.black,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBackgroundColor() {
    switch (_status) {
      case AnswerStatus.correct:
        return ColorManager.success.withOpacity(0.1);
      case AnswerStatus.incorrect:
        return ColorManager.error.withOpacity(0.1);
      case AnswerStatus.unselected:
        return ColorManager.white;
    }
  }

  Widget _buildAnswerIcon() {
    switch (_status) {
      case AnswerStatus.correct:
        return Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: ColorManager.success,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.check,
            color: ColorManager.white,
            size: 16,
          ),
        );
      
      case AnswerStatus.incorrect:
        return Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: ColorManager.error,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.close,
            color: ColorManager.white,
            size: 16,
          ),
        );
      
      case AnswerStatus.unselected:
        return Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorManager.grey,
              width: 2,
            ),
          ),
        );
    }
  }
}
