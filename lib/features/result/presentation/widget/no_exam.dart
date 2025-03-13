// features/result/presentation/widget/no_exam.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class NoExam extends StatelessWidget {
  const NoExam({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         const Icon(
            Icons.assignment_outlined,
            size: 64,
            color: ColorManager.grey,
          ),
          const SizedBox(height: 16),
          Text(
            'No Exam Results',
            style: getBoldStyle(
              color: ColorManager.black,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Take an exam to see your results here',
            style: getRegularStyle(
              color: ColorManager.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}