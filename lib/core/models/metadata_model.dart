import 'package:exam_app/core/app_data/api/api_constants.dart';

class MetadataModel {
  final int currentPage;
  final int numberOfPages;
  final int limit;

  const MetadataModel({
    required this.currentPage,
    required this.numberOfPages,
    required this.limit,
  });

  factory MetadataModel.fromJson(Map<String, dynamic> json) => MetadataModel(
        currentPage: json[ApiConstants.currentPageKey] as int,
        numberOfPages: json[ApiConstants.numberOfPagesKey] as int,
        limit: json[ApiConstants.limitKey] as int,
      );

  Map<String, dynamic> toJson() => {
        ApiConstants.currentPageKey: currentPage,
        ApiConstants.numberOfPagesKey: numberOfPages,
        ApiConstants.limitKey: limit,
      };
}
