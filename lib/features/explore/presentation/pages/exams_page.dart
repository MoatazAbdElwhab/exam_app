import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/exam_item.dart';
import 'package:exam_app/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExamsPage extends StatelessWidget {
  const ExamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as ({
      String subjectName,
      String subjectID,
      ExploreCubit exploreCubit
    });

    return Scaffold(
      appBar: CustomAppBar(
        title: args.subjectName,
        canPop: true,
      ),
      body: BlocBuilder<ExploreCubit, ExploreState>(
        bloc: args.exploreCubit,
        buildWhen: (previous, current) {
          if (current is GetExamsFail ||
              current is GetExamsLoading ||
              current is GetExamsSuccess) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          switch (state) {
            case GetExamsLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case GetExamsFail():
              return Center(
                child: Text(state.errorMsg),
              );
            case GetExamsSuccess():
              if (state.exams.isEmpty) {
                return Center(
                  child: Text(
                    'There are no exams',
                    style: getSemiBoldStyle(
                      color: ColorManager.black,
                      fontSize: 18,
                    ),
                  ),
                );
              }
              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          var examsArgs = (
                            subjectName: args.subjectName,
                            examModel: state.exams[index],
                            exploreCubit: args.exploreCubit,
                          );
                          Navigator.of(context).pushNamed(
                            Routes.startExam,
                            arguments: examsArgs,
                          );
                        },
                        child: ExamItem(
                          examModel: state.exams[index],
                          isResult: false,
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 4),
                      itemCount: state.exams.length,
                    ),
                  ),
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
