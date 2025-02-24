// features/result/presentation/pages/result_details.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/result/presentation/cubit/result_state.dart';

class ResultDetails extends StatefulWidget {
  final QuestionRequestModel questionRequest;

  const ResultDetails({super.key, required this.questionRequest});

  @override
  State<ResultDetails> createState() => _ResultDetailsState();
}

class _ResultDetailsState extends State<ResultDetails> {
  Map<int, int?> selectedAnswers = {};

  void onSelect(int questionIndex, int answerIndex) {
    setState(() {
      selectedAnswers[questionIndex] = answerIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: const CustomAppBar(title: 'Result Details', canPop: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ResultCubit, ResultState>(
          builder: (context, state) {
            if (state is ResultLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is QuestionsLoaded) {
              final questions = state.questions;
              return ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, questionIndex) {
                  final question = questions[questionIndex];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Question ID: ${question.answers?[questionIndex].questionId ?? 'No Question ID'}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      ...List.generate(
                        question.answers?.length ?? 0,
                        (optionIndex) {
                          final answer = question.answers?[optionIndex];
                          bool isCorrect = answer?.correct ==
                              question.answers?[questionIndex].correct;
                          bool isSelected =
                              selectedAnswers[questionIndex] == optionIndex;

                          return GestureDetector(
                            onTap: () => onSelect(questionIndex, optionIndex),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? (isCorrect
                                        ? Colors.green[200]
                                        : Colors.red[200])
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: isSelected
                                      ? (isCorrect ? Colors.green : Colors.red)
                                      : Colors.grey,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    isSelected
                                        ? (isCorrect
                                            ? Icons.check_circle
                                            : Icons.cancel)
                                        : Icons.check_box_outline_blank,
                                    color: isSelected
                                        ? (isCorrect ? Colors.green : Colors.red)
                                        : Colors.blue,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    answer?.correct ?? 'No Answer',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              );
            } else if (state is ResultError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}