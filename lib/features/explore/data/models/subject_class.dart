// features/explore/data/model/subject_class.dart
import 'package:exam_app/core/resources/icon_manager.dart';

class SubjectClass {
  final String title;
  final String imageUrl;

  SubjectClass({required this.title, required this.imageUrl});
}

final List subjectClasses = [
  SubjectClass(title: 'Language', imageUrl: IconManager.languagePng),
  SubjectClass(title: 'Math', imageUrl: IconManager.mathPng),
  SubjectClass(title: 'Art', imageUrl: IconManager.artPng),
  SubjectClass(title: 'Science', imageUrl: IconManager.sciencePng),
];