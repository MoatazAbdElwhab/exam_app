import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/utils/utils.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/features/explore/data/models/check_result/check_result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExamScorePage extends StatelessWidget {
  const ExamScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as CheckResult;
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Exam score',
        canPop: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your score',
              style: getMediumStyle(
                color: ColorManager.black,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 8.0,
                  percent: UIUtils.parsePercentage(args.total ?? '0'),
                  center: Text(
                    UIUtils.formatPercentage(args.total ?? '0'),
                    style:
                        getMediumStyle(color: ColorManager.black, fontSize: 20),
                  ),
                  progressColor: ColorManager.blue,
                  backgroundColor: ColorManager.error,
                  circularStrokeCap: CircularStrokeCap.round,
                ),
                // SizedBox(
                //   height: 120,
                //   width: 120,
                //   child: CircularProgressIndicator(
                //     value: UIUtils.parsePercentage(args.total ?? '0'),
                //     backgroundColor: ColorManager.error,
                //     color: ColorManager.blue,
                //     strokeWidth: 8,
                //     strokeCap: StrokeCap.round,
                //   ),
                // ),
                const SizedBox(width: 24),
                SizedBox(
                  width: 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Correct',
                            style: getMediumStyle(
                              color: ColorManager.blue,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorManager.blue,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              args.correct.toString(),
                              style: getMediumStyle(
                                color: ColorManager.blue,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Incorrect',
                            style: getMediumStyle(
                              color: ColorManager.error,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorManager.error,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              args.wrong.toString(),
                              style: getMediumStyle(
                                color: ColorManager.error,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            CustomElevatedButton(
              title: 'Show results',
              onTap: () {},
              style: getMediumStyle(color: ColorManager.white, fontSize: 16.sp),
            ),
            const SizedBox(height: 24),
            CustomElevatedButton(
              title: 'Start again',
              onTap: () {},
              style: getMediumStyle(color: ColorManager.blue, fontSize: 16.sp),
              backgroundColor: ColorManager.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: const BorderSide(color: ColorManager.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
