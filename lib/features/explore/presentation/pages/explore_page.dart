// features/explore/presentation/pages/explore_page.dart

// features/explore/presentation/pages/explore_page.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';

import 'package:exam_app/features/explore/data/model/subject_class.dart';
import 'package:exam_app/features/explore/presentation/widget/subject_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //text surveys
            SizedBox(height: 56.h),
            Text(
              'Surveys',
              style: getMediumStyle(
                color: ColorManager.blue,
                fontSize: 22.sp,
              ),
            ),

            //search textfield and icon
            SizedBox(height: 16.h),

            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
              ),
            ),

            //browse by subject
            SizedBox(height: 30.h),
            Text(
              "Browse by Subject",
              style: getMediumStyle(
                color: ColorManager.black,
                fontSize: 18.sp,
              ),
            ),

            //listview of subjects
            SizedBox(height: 12.h),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: subjectClasses.length,
                itemBuilder: (context, index) {
                  final subject = subjectClasses[index];
                  return GestureDetector(
                    onTap: () => {},
                    child: SubjectCard(
                      image: subject.imageUrl,
                      title: subject.title,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}