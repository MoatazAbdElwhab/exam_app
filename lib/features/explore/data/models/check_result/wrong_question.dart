class WrongQuestion {
  final String? qid;
  final String? question;
  final String? inCorrectAnswer;
  final String? correctAnswer;

  const WrongQuestion({
    this.qid,
    this.question,
    this.inCorrectAnswer,
    this.correctAnswer,
  });

  factory WrongQuestion.fromJson(Map<String, dynamic> json) => WrongQuestion(
        qid: json['QID'] as String?,
        question: json['Question'] as String?,
        inCorrectAnswer: json['inCorrectAnswer'] as String?,
        correctAnswer: json['correctAnswer'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'QID': qid,
        'Question': question,
        'inCorrectAnswer': inCorrectAnswer,
        'correctAnswer': correctAnswer,
      };
}
