import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/icon_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:exam_app/features/explore/presentation/pages/exams_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartExamPage extends StatelessWidget {
  const StartExamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ArgsObj;
    return Scaffold(
      appBar: const CustomAppBar(
        title: '',
        canPop: true,
      ),
      body: BlocBuilder<ExploreCubit, ExploreState>(
        bloc: args.exploreCubit..getAllQuestionsOnExam(args.examModel.id),
        buildWhen: (previous, current) {
          if (current is GetQuestionsFail ||
              current is GetQuestionsLoading ||
              current is GetQuestionsSuccess) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          switch (state) {
            case GetQuestionsLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case GetQuestionsFail():
              return Center(
                child: Text(
                  state.errorMsg,
                  style: getSemiBoldStyle(color: ColorManager.black),
                ),
              );
            case GetQuestionsSuccess():
              if (state.questions.isEmpty) {
                return Center(
                  child: Text(
                    'There are no questions available',
                    style: getSemiBoldStyle(color: ColorManager.black),
                  ),
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 16),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              IconManager.examPng,
                              fit: BoxFit.cover,
                              height: 47,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                args.subjectName,
                                style: getSemiBoldStyle(
                                    color: ColorManager.black, fontSize: 20),
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${args.examModel.duration} Minutes',
                              style: getRegularStyle(
                                  color: ColorManager.blue, fontSize: 13),
                              maxLines: 1,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              args.examModel.title,
                              style: getMediumStyle(
                                color: ColorManager.black,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 1,
                              height: 20,
                              color: ColorManager.blue.withOpacity(0.3),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${args.examModel.numberOfQuestions} Question',
                              style: getRegularStyle(
                                color: ColorManager.grey,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: .5,
                    color: ColorManager.blue.withOpacity(0.1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 24),
                    child: CustomElevatedButton(
                      title: 'Start',
                      onTap: () {},
                      backgroundColor: ColorManager.blue,
                    ),
                  )
                ],
              );

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
