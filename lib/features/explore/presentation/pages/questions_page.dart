import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/features/explore/data/models/exam_response/exam_model.dart';
import 'package:exam_app/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:exam_app/features/explore/presentation/widget/answers_radio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionsPage extends StatefulWidget {
  const QuestionsPage({super.key});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  String? _selectedAnswer;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ({
      String subjectName,
      ExamModel examModel,
      ExploreCubit exploreCubit,
    });
    final cubit = args.exploreCubit;
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Exam',
        canPop: true,
        minutes: args.examModel.duration,
      ),
      body: BlocBuilder<ExploreCubit, ExploreState>(
        bloc: cubit,
        buildWhen: (previous, current) {
          if (current is ChangeAnswer) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
            child: Column(
              children: [
                Text(
                  'Question ${cubit.activeQuestion + 1} of ${cubit.questionList.length}',
                  style:
                      getMediumStyle(color: ColorManager.grey, fontSize: 14.sp),
                ),
                LinearProgressIndicator(
                  value: (cubit.activeQuestion + 1) / cubit.questionList.length,
                  minHeight: 6,
                  color: ColorManager.blue,
                  backgroundColor: ColorManager.black.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                const SizedBox(height: 28),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    cubit.questionList[cubit.activeQuestion].question,
                    style:
                        getMediumStyle(color: ColorManager.black, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 24),
                AnswersRadio(
                  question: cubit.questionList[cubit.activeQuestion],
                  onChanged: cubit.onChangeSelectedAnswer,
                  selectedAnswer: cubit.selectedAnswer,
                ),
                const SizedBox(height: 64),
                Row(
                  children: [
                    if (cubit.activeQuestion > 0) ...[
                      Expanded(
                        child: CustomElevatedButton(
                          title: 'Back',
                          onTap: () {
                            cubit.backQuestion();
                          },
                          height: 48,
                          style: getMediumStyle(
                            color: ColorManager.blue,
                            fontSize: 16.sp,
                          ),
                          backgroundColor: ColorManager.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: ColorManager.blue),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                    ],
                    Expanded(
                      child: CustomElevatedButton(
                        title: 'Next',
                        onTap: () {
                          cubit.nextQuestion(context);
                        },
                        height: 48,
                        style: getMediumStyle(
                          color: ColorManager.white,
                          fontSize: 16.sp,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
