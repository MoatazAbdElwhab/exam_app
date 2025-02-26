import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/icon_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/features/explore/data/models/exam_response/exam_model.dart';
import 'package:flutter/material.dart';

class ExamItem extends StatelessWidget {
  final ExamModel examModel;
  final bool isResult;
  const ExamItem({
    super.key,
    required this.examModel,
    this.isResult = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 103,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 2,
            offset: const Offset(0, 0),
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            IconManager.examPng,
            width: 60,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  examModel.title,
                  style: getSemiBoldStyle(color: ColorManager.black),
                ),
                Text(
                  "${examModel.numberOfQuestions} Questions",
                  style: getMediumStyle(color: ColorManager.grey),
                ),
                const Spacer(),
                Visibility(
                  visible: isResult,
                  child: RichText(
                    maxLines: 1,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "18",
                          style: getSemiBoldStyle(color: ColorManager.blue),
                        ),
                        TextSpan(
                          text: " corrected answers in ",
                          style: getMediumStyle(color: ColorManager.blue),
                        ),
                        TextSpan(
                          text: "25",
                          style: getSemiBoldStyle(color: ColorManager.blue),
                        ),
                        TextSpan(
                          text: " min.",
                          style: getMediumStyle(color: ColorManager.blue),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            "${examModel.duration} Minutes",
            style: getMediumStyle(
                color: isResult ? ColorManager.black : ColorManager.blue),
          ),
        ],
      ),
    );
  }
}
