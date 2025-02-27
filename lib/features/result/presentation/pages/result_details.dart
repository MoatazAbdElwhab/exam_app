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
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                final question = questions[index];
                final isCorrect = question.selectedAnswer == question.correct;

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              question.question ?? '',
                              style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (question.answers != null)
                        ...question.answers!.map((answer) {
                          final isSelected = answer.key == question.selectedAnswer;
                          final isCorrectAnswer = answer.answer == question.correct;

                          Color getAnswerColor() {
                            if (isCorrectAnswer) {
                              return ColorManager.success;
                            } else if (isSelected) {
                              return ColorManager.error;
                            }
                            return ColorManager.grey;
                          }

                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: (isSelected || isCorrectAnswer) ? getAnswerColor().withOpacity(0.15) : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: getAnswerColor(),
                                width: (isSelected || isCorrectAnswer) ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  isCorrectAnswer
                                      ? Icons.check_circle
                                      : isSelected
                                          ? Icons.cancel
                                          : Icons.radio_button_unchecked,
                                  color: getAnswerColor(),
                                  size: 24,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    answer.answer ?? '',
                                    style: getMediumStyle(
                                      color: (isSelected || isCorrectAnswer) ? getAnswerColor() : ColorManager.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                    ],
                  ),
                );
              },
            ),
    );
  }
}