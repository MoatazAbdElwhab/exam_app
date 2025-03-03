// features/result/presentation/widget/result_container.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/result/presentation/pages/result_details.dart';
import 'package:flutter/material.dart';

class ResultContainer extends StatelessWidget {
  final BuildContext context;
  final QuestionRequestModel question;
  final UserQuestionData? userAnswer;
  final int index;
  final int totalQuestions;
  final int correctAnswers;
  final int timeSpent;
  final List<QuestionRequestModel> examQuestions;
  final Map<String, UserQuestionData> userAnswers;

  const ResultContainer({
    super.key,
    required this.context,
    required this.question,
    required this.userAnswer,
    required this.index,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.timeSpent,
    required this.examQuestions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultDetails(
              question: question,
              userAnswer: userAnswer,
              examQuestions: examQuestions,
              userAnswers: userAnswers,
            ),
          ),
        );
      },
      child: Container(
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
        child: Row(
          children: [
            // Left side - Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(
                question.subject?.icon ?? '',
               
              ),
            ),
            const SizedBox(width: 16),
            // Right side - Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        question.exam?.title ?? 'Exam Results',
                        style: getBoldStyle(
                          color: ColorManager.black,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '$timeSpent min',
                        style: getMediumStyle(
                          color: ColorManager.grey,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Questions count
                  Text(
                    '$totalQuestions Questions',
                    style: getRegularStyle(
                      color: ColorManager.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Corrected answers
                  Text(
                    '$correctAnswers corrected answers in $timeSpent min.',
                    style: getMediumStyle(
                      color: ColorManager.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
