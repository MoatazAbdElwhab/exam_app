import 'package:exam_app/core/app_data/api/api_constants.dart';
import 'package:exam_app/core/models/metadata_model.dart';
import 'package:exam_app/features/explore/data/models/exam_response/exam_model.dart';

class ExamResponse {
  final String message;
  final MetadataModel metadata;
  final List<ExamModel> exams;

  const ExamResponse({
    required this.message,
    required this.metadata,
    required this.exams,
  });

  factory ExamResponse.fromJson(Map<String, dynamic> json) => ExamResponse(
        message: json[ApiConstants.messageKey] as String,
        metadata: MetadataModel.fromJson(
            json[ApiConstants.metadataKey] as Map<String, dynamic>),
        exams: (json[ApiConstants.examsKey] as List<dynamic>)
            .map((e) => ExamModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        ApiConstants.messageKey: message,
        ApiConstants.metadataKey: metadata.toJson(),
        ApiConstants.examsKey: exams.map((e) => e.toJson()).toList(),
      };
}
