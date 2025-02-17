// features/result/presentation/pages/result_container.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/icon_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class ResultContainer extends StatelessWidget {
  const ResultContainer({
    super.key,
    required this.context,
    required this.index,
    
  });

  final BuildContext context;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Language",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
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
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      IconManager.artPng,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "High level",
                            style: getSemiBoldStyle(color: ColorManager.black),
                          ),
                          Text(
                            "20 Questions",
                            style: getMediumStyle(color: ColorManager.grey),
                          ),
                          const SizedBox(height: 6),
                          RichText(
                            text: TextSpan(
                              text: "18 corrected answers in ",
                              style: getMediumStyle(color: ColorManager.blue),
                              children: [
                                TextSpan(
                                  text: "25 min.",
                                  style: getSemiBoldStyle(
                                      color: ColorManager.blue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      "30 Minutes",
                      style: getMediumStyle(color: ColorManager.grey),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
