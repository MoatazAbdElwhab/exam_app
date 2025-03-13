// features/result/presentation/pages/result_details.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:exam_app/features/result/domain/entities/exam_score.dart';
import 'package:exam_app/features/result/presentation/widget/exam_question_card.dart';
import 'package:flutter/material.dart';

class ResultDetails extends StatelessWidget {
  final List<QuestionModelHive> questions;
  final ExamScore examScore;

  const ResultDetails({
    super.key,
    required this.questions,
    required this.examScore,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Answers Review',
        canPop: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: questions.length,
        itemBuilder: (context, index) => ExamQuestionCard(
          question: questions[index],
        ),
      ),
    );
  }
}
