// features/result/presentation/widget/result_container.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:exam_app/features/result/domain/entities/exam_score.dart';
import 'package:flutter/material.dart';

class ResultContainer extends StatelessWidget {
  final List<QuestionModelHive> questions;
  final ExamScore examScore;

  const ResultContainer({
    super.key,
    required this.questions,
    required this.examScore,
  });

  String _formatDuration(int minutes) => '$minutes Minutes';
  String _formatQuestionCount(int count) => '$count Question';

  @override
  Widget build(BuildContext context) {
    final duration = questions.first.duration;

    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildQuizIcon(),
            Expanded(
              child: _buildQuizDetails(duration),
            ),
            _buildInfoChip(_formatDuration(duration)),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizIcon() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.lightBlue.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
      child: Image.network(
        questions.first.iconUrl!,
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildQuizDetails(int duration) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            questions.first.examTitle!,
            style: getBoldStyle(
              color: ColorManager.black,
              fontSize: 18,
            ),
          ),
          _buildInfoChip(_formatQuestionCount(questions.length)),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${examScore.correctAnswers} Corrected Answers in ${_formatDuration(duration)}',
                  style: getRegularStyle(
                    color: ColorManager.blue,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: ColorManager.lightBlue.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: getRegularStyle(
          color: ColorManager.grey,
          fontSize: 12,
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context) {
    Navigator.pushNamed(
      context,
      Routes.resultDetails,
      arguments: {
        'questions': questions,
        'examScore': examScore,
      },
    );
  }
}
