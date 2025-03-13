// features/result/domain/entities/exam_score.dart
import 'package:equatable/equatable.dart';

class ExamScore extends Equatable {
  final int correctAnswers;
  final int totalQuestions;
  final double scorePercentage;

  const ExamScore({
    required this.correctAnswers,
    required this.totalQuestions,
    required this.scorePercentage,
  });

  @override
  List<Object?> get props => [correctAnswers, totalQuestions, scorePercentage];

  @override
  String toString() => 'ExamScore(correctAnswers: $correctAnswers, totalQuestions: $totalQuestions, scorePercentage: ${scorePercentage.toStringAsFixed(1)}%)';
}
