// features/result/presentation/pages/result_page.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/features/result/presentation/widget/result_container.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: const CustomAppBar(
        title: 'Result',
        canPop: false,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: 2,
        itemBuilder: (context, index) {
          return ResultContainer(
            context: context,
            index: index,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}