import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/exam_item.dart';
import 'package:exam_app/features/explore/data/models/exam_response/exam_model.dart';
import 'package:flutter/material.dart';

class SectionExam extends StatelessWidget {
  final List<ExamModel> examModel;
  const SectionExam({
    super.key,
    required this.examModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   examModel.title,
          //   style: getMediumStyle(color: ColorManager.black, fontSize: 18),
          // ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
            itemBuilder: (context, index) => ExamItem(
              examModel: examModel[index],
              isResult: false,
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemCount: examModel.length,
          ),
        ],
      ),
    );
  }
}
