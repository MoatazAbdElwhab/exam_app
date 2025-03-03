// features/result/presentation/pages/results_page.dart
import 'package:exam_app/core/di/injectable.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/result/presentation/widget/no_exam.dart';
import 'package:exam_app/features/result/presentation/widget/result_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ResultCubit>()..fetchQuestions(),
      child: const ResultPageView(),
    );
  }
}

class ResultPageView extends StatelessWidget {
  const ResultPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Results'),
      body: BlocBuilder<ResultCubit, ResultState>(
        builder: (context, state) {
          if (state is ResultLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ResultError) {
            return state.message.isNotEmpty
                ? Center(child: Text(state.message))
                : const Center(child: Text('Something went wrong'));
          }

          if (state is QuestionsLoaded) {
            if (state.questions.isEmpty) {
              return const NoExam();
            }

            // Group questions by exam
            final examGroups = <String?, List<QuestionRequestModel>>{};
            for (var question in state.questions) {
              final examId = question.exam?.id;
              if (examId != null) {
                examGroups.putIfAbsent(examId, () => []).add(question);
              }
            }

            return RefreshIndicator(
              onRefresh: () async {
                context.read<ResultCubit>().fetchQuestions();
              },
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: examGroups.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final examQuestions = examGroups.values.elementAt(index);
                  final firstQuestion = examQuestions.first;

                  // Calculate total questions for this exam
                  final totalQuestions = examQuestions.length;
                  int correctAnswers = 0;

                  // Count correct answers for this exam
                  for (var question in examQuestions) {
                    final questionId = question.id;
                    if (questionId != null) {
                      final userAnswer = state.userAnswers[questionId];
                      if (userAnswer != null &&
                          userAnswer.userAnswer == question.correct) {
                        correctAnswers++;
                      }
                    }
                  }

                  final timeSpent = firstQuestion.exam?.duration ?? 0;

                  return ResultContainer(
                    context: context,
                    question: firstQuestion,
                    userAnswer: state.userAnswers[firstQuestion.id],
                    index: index,
                    totalQuestions: totalQuestions,
                    correctAnswers: correctAnswers,
                    timeSpent: timeSpent,
                    examQuestions: examQuestions,
                    userAnswers: state.userAnswers,
                  );
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
