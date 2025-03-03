// features/result/presentation/pages/result_details.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
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
                          q.question ?? '',
                          style: getBoldStyle(
                            color: ColorManager.black,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...q.answers.map((answer) {
                          final isCorrect = answer.key == q.correct;
                          final isUserAnswer = userAns?.userAnswer == answer.key;

                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isCorrect
                                  ? Colors.green.withOpacity(0.1)
                                  : isUserAnswer && !isCorrect
                                      ? Colors.red.withOpacity(0.1)
                                      : Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isCorrect
                                      ? Icons.check_circle
                                      : isUserAnswer && !isCorrect
                                          ? Icons.cancel
                                          : Icons.radio_button_unchecked,
                                  color: isCorrect
                                      ? Colors.green
                                      : isUserAnswer && !isCorrect
                                          ? Colors.red
                                          : Colors.grey,
                                  size: 20,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    answer.answer ?? '',
                                    style: getMediumStyle(
                                      color: isCorrect
                                          ? Colors.green
                                          : isUserAnswer && !isCorrect
                                              ? Colors.red
                                              : ColorManager.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
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
