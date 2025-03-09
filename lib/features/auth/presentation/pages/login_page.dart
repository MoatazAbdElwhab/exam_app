// features/auth/presentation/pages/login_page.dart
import 'package:exam_app/core/database/application_storage.dart';
import 'package:exam_app/core/database/question_model.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/features/auth/presentation/pages/result.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: getMediumStyle(
            fontSize: 20,
            color: ColorManager.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final String userId =
                        ApplicationStorage.getData(ApplicationStorage.userID) ??
                            "";
                    final String examId = "exam_2";
                    final String questionKey = "${userId}_${examId}_q1";

                    ApplicationStorage.cachedQuestion(
                      questionKey,
                      QuestionModel(
                        id: questionKey,
                        examID: examId,
                        questionID: "1",
                        question: "What is the capital of Nigeria?",
                        answes: ["Lagos", "Abuja", "Kano", "Ibadan"],
                        correctAnswer: "Abuja",
                        userAnswer: "kano",
                        duration: "10",
                        isCompleted: true,
                      ),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Result(userId: userId),
                      ),
                    );
                  },
                  child: const Text("Finish Exam"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
