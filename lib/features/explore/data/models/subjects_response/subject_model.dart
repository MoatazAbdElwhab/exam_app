import 'package:exam_app/core/app_data/api/api_constants.dart';

class SubjectModel {
  final String id;
  final String name;
  final String icon;
  final DateTime createdAt;

  const SubjectModel({
    required this.id,
    required this.name,
    required this.icon,
    required this.createdAt,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
        id: json[ApiConstants.idKey] as String,
        name: json[ApiConstants.nameKey] as String,
        icon: json[ApiConstants.iconKey] as String,
        createdAt: DateTime.parse(json[ApiConstants.createdAtKey] as String),
      );

  Map<String, dynamic> toJson() => {
        ApiConstants.idKey: id,
        ApiConstants.nameKey: name,
        ApiConstants.iconKey: icon,
        ApiConstants.createdAtKey: createdAt.toIso8601String(),
      };
}
