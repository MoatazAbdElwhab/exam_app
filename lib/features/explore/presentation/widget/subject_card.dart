// features/explore/presentation/widget/subject_card.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

class SubjectCard extends StatelessWidget {
  final String title;
  final String iconUrl;
  const SubjectCard({super.key, required this.title, required this.iconUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // border: Border.all(width: 1, color: ColorManager.grey),
        color: ColorManager.white,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(iconUrl, width: 40, height: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
