// features/result/presentation/pages/result_details.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/features/result/presentation/pages/question_model.dart';
import 'package:flutter/material.dart';

class ResultDetails extends StatefulWidget {
  ResultDetails({super.key});

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
        child: ListView.builder(
          itemCount: questionList.length,
          itemBuilder: (context, questionIndex) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  questionList[questionIndex].question,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ...List.generate(questionList[questionIndex].options.length,
                    (optionIndex) {
                  bool isCorrect =
                      optionIndex == questionList[questionIndex].correctIndex;
                  bool isSelected =
                      selectedAnswers[questionIndex] == optionIndex;

                  return GestureDetector(
                    onTap: () => onSelect(questionIndex, optionIndex),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? (isCorrect ? Colors.green[200] : Colors.red[200])
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
                            questionList[questionIndex].options[optionIndex],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
