// features/results/presentation/pages/result_details.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';

class ResultDetails extends StatelessWidget {
  final List<QuestionRequestModel> questions;

  const ResultDetails({
    super.key,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    // Check if any questions have been answered
    bool hasAnsweredQuestions = questions.any((q) => q.selectedAnswer != null);

    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: const CustomAppBar(title: 'Result Details', canPop: true),
      body: !hasAnsweredQuestions
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.quiz_outlined,
                    size: 64,
                    color: ColorManager.blue,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Results Yet',
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please take the exam first to see your results',
                    style: getMediumStyle(
                      color: ColorManager.grey,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to exams list
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Go Back',
                      style: getSemiBoldStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  final question = questions[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: ColorManager.black.withOpacity(0.1),
                          blurRadius: 4,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Question ${index + 1}',
                          style: getBoldStyle(
                            color: ColorManager.blue,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          question.question ?? 'No question text',
                          style: getMediumStyle(
                            color: ColorManager.black,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (question.answers != null) ...[
                          ...question.answers!.map((answer) {
                            final isCorrect = answer.key == question.correct;
                            final isUserChoice = answer.key == question.selectedAnswer;
                            
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isCorrect
                                    ? Colors.green.withOpacity(0.1)
                                    : isUserChoice
                                        ? Colors.red.withOpacity(0.1)
                                        : ColorManager.grey,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isCorrect
                                      ? Colors.green
                                      : isUserChoice
                                          ? Colors.red
                                          : ColorManager.grey,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isCorrect
                                          ? Colors.green
                                          : isUserChoice
                                              ? Colors.red
                                              : Colors.transparent,
                                      border: Border.all(
                                        color: isCorrect
                                            ? Colors.green
                                            : isUserChoice
                                                ? Colors.red
                                                : ColorManager.grey,
                                      ),
                                    ),
                                    child: Center(
                                      child: isCorrect
                                          ? const Icon(
                                              Icons.check,
                                              size: 16,
                                              color: Colors.white,
                                            )
                                          : isUserChoice
                                              ? const Icon(
                                                  Icons.close,
                                                  size: 16,
                                                  color: Colors.white,
                                                )
                                              : null,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      answer.answer ?? 'No answer text',
                                      style: getMediumStyle(
                                        color: ColorManager.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ],
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: ColorManager.grey.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: ColorManager.blue,
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Your Answer: ${question.selectedAnswer ?? 'Not answered'}',
                                style: getMediumStyle(
                                  color: ColorManager.black,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}