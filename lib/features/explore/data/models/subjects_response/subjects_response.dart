import 'package:exam_app/core/app_data/api/api_constants.dart';

import '../../../../../core/models/metadata_model.dart';
import 'subject_model.dart';

class SubjectsResponse {
  final String message;
  final MetadataModel metadata;
  final List<SubjectModel> subjects;

  const SubjectsResponse({
    required this.message,
    required this.metadata,
    required this.subjects,
  });

  factory SubjectsResponse.fromJson(Map<String, dynamic> json) {
    return SubjectsResponse(
      message: json[ApiConstants.messageKey] as String,
      metadata: MetadataModel.fromJson(
          json[ApiConstants.metadataKey] as Map<String, dynamic>),
      subjects: (json[ApiConstants.subjectsKey] as List<dynamic>)
          .map((e) => SubjectModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        ApiConstants.messageKey: message,
        ApiConstants.metadataKey: metadata.toJson(),
        ApiConstants.subjectsKey: subjects.map((e) => e.toJson()).toList(),
      };
}
