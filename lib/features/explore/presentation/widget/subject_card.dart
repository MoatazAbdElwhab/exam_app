// features/explore/presentation/widget/subject_card.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';

class SubjectCard extends StatelessWidget {
  final String title;
  final String image;
  const SubjectCard({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shadowColor: ColorManager.grey,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(image, width: 40, height: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
