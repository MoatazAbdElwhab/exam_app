// features/result/presentation/pages/exam_details_page.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:exam_app/features/result/domain/entities/exam_score.dart';
import 'package:exam_app/features/result/presentation/widget/exam_question_card.dart';
import 'package:flutter/material.dart';

class ExamDetailsPage extends StatelessWidget {
  final List<QuestionModelHive> questions;
  final ExamScore examScore;

  const ExamDetailsPage({
    super.key,
    required this.questions,
    required this.examScore,
  });

  @override
  Widget build(BuildContext context) {
    //final firstQuestion = questions.first;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        elevation: 0,
        leading: IconButton(
          icon:const Icon(Icons.arrow_back, color: ColorManager.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Exam Details',
          style: getBoldStyle(
            color: ColorManager.black,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildScoreHeader(),
            _buildExamInfoSection(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Questions',
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildQuestionsList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreHeader() {
    final double percentage = examScore.scorePercentage;
    final Color scoreColor = percentage >= 70 
        ? ColorManager.success 
        : percentage >= 50 
            ? ColorManager.error 
            : ColorManager.error;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: getBoldStyle(
              color: scoreColor,
              fontSize: 48,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${examScore.correctAnswers} out of ${examScore.totalQuestions} correct',
            style: getMediumStyle(
              color: ColorManager.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamInfoSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorManager.white,
        border: Border(
          bottom: BorderSide(
            color: ColorManager.grey.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'HTML Quiz',
            style: getBoldStyle(
              color: ColorManager.black,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildInfoChip('High Level'),
              const SizedBox(width: 8),
              _buildInfoChip('${questions.length} Questions'),
              const SizedBox(width: 8),
              _buildInfoChip('${questions.first.duration} Minutes'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: ColorManager.lightBlue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: getMediumStyle(
          color: ColorManager.blue,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildQuestionsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
       // debugPrint('Building question ${index + 1}:');
        //debugPrint('- Question ID: ${question.questionID}');
        //debugPrint('- User Answer: ${question.userAnswer}');
        //debugPrint('- Correct Answer: ${question.correctAnswer}');
        return ExamQuestionCard(
          question: question,
        );
      },
    );
  }
}
