// features/result/data/data_models/history_response_model.dart
// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class HistoryResponseModel {
  final String? message;
  final List<HistoryModel>? history;

  const HistoryResponseModel({
    this.message,
    this.history,
  });

  factory HistoryResponseModel.fromJson(Map<String, dynamic> json) {
    return HistoryResponseModel(
      message: json['message'] as String?,
      history: (json['history'] as List<dynamic>?)
          ?.map((e) => HistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'history': history?.map((e) => e.toJson()).toList(),
    };
  }
}

class HistoryModel {
  final String? id;
  final String? examId;
  final String? userId;
  final String? examName;
  final int? score;
  final String? createdAt;

  const HistoryModel({
    this.id,
    this.examId,
    this.userId,
    this.examName,
    this.score,
    this.createdAt,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: json['_id'] as String?,
      examId: json['examId'] as String?,
      userId: json['userId'] as String?,
      examName: json['examName'] as String?,
      score: json['score'] as int?,
      createdAt: json['createdAt'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'examId': examId,
      'userId': userId,
      'examName': examName,
      'score': score,
      'createdAt': createdAt,
    };
  }
}
