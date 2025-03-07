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
    return switch (state.status) {
      ResultStatus.initial => const SizedBox.shrink(),
      ResultStatus.loading => const Center(child: CircularProgressIndicator()),
      ResultStatus.error when state.errorMessage != null => 
        ResultErrorView(message: state.errorMessage!),
      ResultStatus.questionsLoaded when state.questions != null && state.userAnswers != null => 
        ExamResultsList(
          questions: state.questions!,
          userAnswers: state.userAnswers!,
        ),
      ResultStatus.answerSubmitted when state.response != null =>
        Center(child: Text('Answer submitted successfully: ${state.response!.message ?? ''}')),
      ResultStatus.allAnswersSubmitted when state.questions != null =>
        ExamResultsList(
          questions: state.questions!,
          userAnswers: state.userAnswers ?? {},
        ),
      ResultStatus.historyLoaded when state.history != null =>
        Center(child: Text('History loaded: ${state.history!.toString()}')),
      _ => const Center(
        child: Text(
          'Unexpected state',
          style: TextStyle(color: Colors.red),
        ),
      ),
    };
  }
}
