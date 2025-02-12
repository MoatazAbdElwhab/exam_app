// features/explore/presentation/pages/subject_page.dart
import 'package:exam_app/features/explore/data/models/subject_class.dart';
import 'package:flutter/widgets.dart';

class SubjectPage extends StatelessWidget {
  final SubjectClass subjectClass;
  const SubjectPage({super.key, required this.subjectClass});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image(image: AssetImage(subjectClass.imageUrl)),
        Text(subjectClass.title),
      ],
    );
  }
}
