// features/result/presentation/widget/result_container.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:exam_app/features/result/domain/entities/exam_score.dart';
import 'package:exam_app/features/result/presentation/pages/result_details.dart';
import 'package:flutter/material.dart';

class ResultContainer extends StatelessWidget {
  final List<QuestionModelHive> questions;
  final ExamScore examScore;

  const ResultContainer({
    super.key,
    required this.questions,
    required this.examScore,
  });

  String _formatDuration(int minutes, {bool short = false}) {
    if (short) {
      return '$minutes min';
    }
    return '$minutes ${minutes == 1 ? 'Minute' : 'Minutes'}';
  }

  @override
  Widget build(BuildContext context) {
    // Per Memory a74ae1d4, use QuestionModelHive directly
    final duration = questions.first.duration;
    
    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      child: Container(
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
              'HTML',
              style: getMediumStyle(
                color: ColorManager.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: ColorManager.lightBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.school_outlined,
                    color: ColorManager.blue,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HTML Quiz',
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              'High Level',
                              style: getRegularStyle(
                                color: ColorManager.grey,
                                fontSize: 12,
                              ),
                            ),
                            _buildDot(),
                            Text(
                              '${questions.length} Questions',
                              style: getRegularStyle(
                                color: ColorManager.grey,
                                fontSize: 12,
                              ),
                            ),
                            _buildDot(),
                            Text(
                              _formatDuration(duration),
                              style: getRegularStyle(
                                color: ColorManager.grey,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${examScore.correctAnswers} corrected answers in ${_formatDuration(duration, short: true)}',
              style: getMediumStyle(
                color: ColorManager.blue,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        '•',
        style: getRegularStyle(
          color: ColorManager.grey,
          fontSize: 12,
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultDetails(
          questions: questions,
          examScore: examScore,
        ),
      ),
    );
  }
}
