import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/features/result/data/data_models/question_request_model.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/result/presentation/widget/exam_group_item.dart';
import 'package:exam_app/features/result/presentation/widget/no_exam.dart';

class ExamResultsList extends StatelessWidget {
  final List<QuestionRequestModel> questions;
  final Map<String, UserQuestionData> userAnswers;
  
  const ExamResultsList({
    super.key, 
    required this.questions,
    required this.userAnswers,
  });
  
  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return const NoExam();
    }

    final groupedQuestions = _groupQuestions(questions);

    return RefreshIndicator(
      onRefresh: () async => context.read<ResultCubit>().fetchQuestions(),
      child: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: groupedQuestions.length,
        separatorBuilder: (_, __) => const SizedBox(height: 16),
        itemBuilder: (context, index) => ExamGroupItem(
          examQuestions: groupedQuestions.values.elementAt(index),
          userAnswers: userAnswers,
          index: index,
        ),
      ),
    );
  }

  Map<String?, List<QuestionRequestModel>> _groupQuestions(
    List<QuestionRequestModel> questions,
  ) {
    return groupBy(questions, (q) => q.exam?.id);
  }
}
