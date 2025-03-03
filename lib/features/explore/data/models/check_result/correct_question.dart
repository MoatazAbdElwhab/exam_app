class CorrectQuestion {
  final String? qid;
  final String? question;
  final String? correctAnswer;

  const CorrectQuestion({
    this.qid,
    this.question,
    this.correctAnswer,
  });

  factory CorrectQuestion.fromJson(Map<String, dynamic> json) {
    return CorrectQuestion(
      qid: json['QID'] as String?,
      question: json['Question'] as String?,
      correctAnswer: json['correctAnswer'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'QID': qid,
        'Question': question,
        'correctAnswer': correctAnswer,
      };
}
