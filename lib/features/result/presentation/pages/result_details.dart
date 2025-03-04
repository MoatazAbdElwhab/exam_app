// features/result/presentation/pages/result_details.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/result/presentation/widget/exam_question_card.dart';
import 'package:flutter/material.dart';

class ResultDetails extends StatelessWidget {
  final QuestionRequestModel question;
  final UserQuestionData? userAnswer;
  final List<QuestionRequestModel> examQuestions;
  final Map<String, UserQuestionData> userAnswers;

  const ResultDetails({
    super.key,
    required this.question,
    required this.userAnswer,
    required this.examQuestions,
    required this.userAnswers,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: question.exam?.title ?? 'Exam Results',
        canPop: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exam Results',
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: examQuestions.length,
                itemBuilder: (context, index) {
                  final q = examQuestions[index];
                  final userAns = userAnswers[q.id];

                  return ExamQuestionCard(
                    question: q,
                    userAnswer: userAns,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
