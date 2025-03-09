// features/auth/presentation/pages/result.dart
import 'package:exam_app/core/database/application_storage.dart';
import 'package:exam_app/core/database/question_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Result extends StatelessWidget {
  final String userId;
  
  const Result({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Result',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: ApplicationStorage.questionBox.listenable(),
        builder: (context, box, child) {
          // Filter questions for current user
          List<QuestionModel> userQuestions = box.values
              .where((question) => question.id.toString().startsWith(userId))
              .toList();
          
          if (userQuestions.isEmpty) {
            return const Center(child: Text('No exam results available'));
          }

          // Group questions by examID
          Map<String, List<QuestionModel>> examGroups = {};
          for (var question in userQuestions) {
            if (!examGroups.containsKey(question.examID)) {
              examGroups[question.examID] = [];
            }
            examGroups[question.examID]!.add(question);
          }

          return ListView.builder(
            itemCount: examGroups.length,
            itemBuilder: (context, examIndex) {
              String examId = examGroups.keys.elementAt(examIndex);
              List<QuestionModel> examQuestions = examGroups[examId]!;
              int correctAnswers = examQuestions
                  .where((q) => q.userAnswer == q.correctAnswer)
                  .length;

              return Card(
                margin: const EdgeInsets.all(8),
                child: ExpansionTile(
                  title: Text('Exam $examId'),
                  subtitle: Text(
                    'Score: $correctAnswers/${examQuestions.length}',
                    style: TextStyle(
                      color: correctAnswers > examQuestions.length / 2
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  children: examQuestions.map((question) {
                    bool isCorrect = question.userAnswer == question.correctAnswer;
                    return ListTile(
                      title: Text(question.question.toString()),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Your answer: ${question.userAnswer}'),
                          Text(
                            'Correct answer: ${question.correctAnswer}',
                            style: TextStyle(
                              color: isCorrect ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      leading: Icon(
                        isCorrect ? Icons.check_circle : Icons.cancel,
                        color: isCorrect ? Colors.green : Colors.red,
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
