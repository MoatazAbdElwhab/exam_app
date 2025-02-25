import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';

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
        child: BlocConsumer<ResultCubit, ResultState>(
          listener: (context, state) {
            if (state is ResultError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            } else if (state is ResultAnswerSubmitted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Answer submitted successfully'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is ResultLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, questionIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.questionRequest.question ?? 'No Question',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...List.generate(
                      widget.questionRequest.answers?.length ?? 0,
                      (optionIndex) {
                        final answer = widget.questionRequest.answers?[optionIndex];
                        bool isCorrect = answer?.key == widget.questionRequest.correct;
                        bool isSelected = selectedAnswers[questionIndex] == optionIndex;

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
                                  answer?.answer ?? 'No Answer',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    if (selectedAnswers.isNotEmpty)
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            final selectedIndex = selectedAnswers[0];
                            if (selectedIndex != null &&
                                widget.questionRequest.answers != null &&
                                selectedIndex < widget.questionRequest.answers!.length) {
                              final selectedAnswer =
                                  widget.questionRequest.answers![selectedIndex];
                              final updatedQuestion = widget.questionRequest.copyWith(
                                selectedAnswer: selectedAnswer.key,
                              );
                              context.read<ResultCubit>().submitAnswer(updatedQuestion);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Submit Answer',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}