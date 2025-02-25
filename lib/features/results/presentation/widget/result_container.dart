// features/results/presentation/widget/result_container.dart
import 'package:exam_app/features/results/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/results/presentation/pages/result_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/icon_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';


class ResultContainer extends StatelessWidget {
  const ResultContainer({
    super.key,
    required this.context,
    required this.index,
  });

  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultCubit, ResultState>(
      builder: (context, state) {
        if (state is QuestionsLoaded) {
          final questions = state.questions;
          if (questions.isEmpty) {
            return const Center(child: Text('No exams available'));
          }

          // Group questions by exam
          final examGroups = <String?, List<QuestionRequestModel>>{};
          for (var question in questions) {
            final examId = question.exam?.id;
            if (examId != null) {
              examGroups.putIfAbsent(examId, () => []).add(question);
            }
          }

          final examEntries = examGroups.entries.toList();
          if (index >= examEntries.length) {
            return const SizedBox();
          }

          final examQuestions = examEntries[index].value;
          final exam = examQuestions.first.exam;
          final subject = examQuestions.first.subject;

          // Calculate correct answers
          int correctAnswers = examQuestions
              .where((q) =>
                  q.selectedAnswer != null && q.selectedAnswer == q.correct)
              .length;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 8),
                child: Text(
                  subject?.name ?? 'Unknown Subject',
                  style: getBoldStyle(
                    color: ColorManager.black,
                    fontSize: 18,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResultDetails(
                        questions: examQuestions,
                      ),
                    ),
                  );
                },
                child: Container(
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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left side - Image
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: ColorManager.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: subject?.icon != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  subject!.icon!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Image.asset(
                                    IconManager.artPng,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Image.asset(
                                IconManager.artPng,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(width: 16),
                      // Middle - Exam info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              exam?.title ?? 'Unknown Exam',
                              style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${exam?.numberOfQuestions ?? 0} Questions',
                              style: getMediumStyle(
                                color: ColorManager.grey,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              '$correctAnswers correct answers in ${exam?.duration ?? 0} min',
                              style: getMediumStyle(
                                color: ColorManager.blue,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Right side - Duration
                      Text(
                        '${exam?.duration ?? 0} Minutes',
                        style: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else if (state is ResultError) {
          return Center(
            child: Text(
              state.message,
              style: getMediumStyle(color: ColorManager.error),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
