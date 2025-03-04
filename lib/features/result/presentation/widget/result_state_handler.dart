// features/result/presentation/widget/result_state_handler.dart
import 'package:flutter/material.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/result/presentation/widget/result_error_view.dart';
import 'package:exam_app/features/result/presentation/widget/exam_results_list.dart';

class ResultStateHandler extends StatelessWidget {
  final ResultState state;
  
  const ResultStateHandler({super.key, required this.state});
  
  @override
  Widget build(BuildContext context) {
    return switch (state) {
      ResultLoading() => const Center(child: CircularProgressIndicator()),
      ResultError(message: var message) => ResultErrorView(message: message),
      QuestionsLoaded(questions: final questions, userAnswers: final userAnswers) => ExamResultsList(
        questions: questions,
        userAnswers: userAnswers,
      ),
      _ => const SizedBox.shrink(),
    };
  }
}
