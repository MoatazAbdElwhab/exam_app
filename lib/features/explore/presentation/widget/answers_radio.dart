import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/features/explore/data/models/questions_response/question_model.dart';
import 'package:flutter/material.dart';

class AnswersRadio extends StatelessWidget {
  final QuestionModel question;
  final Function(String?) onChanged;
  final String? selectedAnswer;
  const AnswersRadio({
    super.key,
    required this.question,
    required this.onChanged,
    required this.selectedAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: question.answers.map(
        (answer) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: RadioListTile<String>(
              title: Text(answer.answer),
              value: answer.key,
              groupValue: selectedAnswer,
              onChanged: onChanged,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              activeColor: ColorManager.blue,
              tileColor: ColorManager.lightBlue,
            ),
          );
        },
      ).toList(),
    );
  }
}
