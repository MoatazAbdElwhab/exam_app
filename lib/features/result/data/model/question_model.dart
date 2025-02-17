// features/result/data/model/question_model.dart
class QuestionModel {
  final String question;
  final List<String> options;
  final int correctIndex;

  QuestionModel(
      {required this.question,
      required this.options,
      required this.correctIndex});
}
List questionList = [
  QuestionModel(
      question: "Select the correctly punctuated sentence.",
      options: [
        "Its going to rain today.",
        "It's going to rain today.",
        "Its going to rain today.",
        "Its going to rain today."
      ],
      correctIndex: 1,
    ),
  QuestionModel(
      question: "Select the correctly punctuated sentence.",
      options: [
        "Its going to rain today.",
        "It's going to rain today.",
        "Its going to rain today.",
        "Its going to rain today."
      ],
      correctIndex: 2,
    ),
];