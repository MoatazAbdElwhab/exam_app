// features/result/presentation/pages/results_page.dart
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/result/presentation/widget/result_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({super.key});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ResultCubit>().fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: const CustomAppBar(
        title: 'Exam Results',
        canPop: false,
      ),
      body: BlocBuilder<ResultCubit, ResultState>(
        builder: (context, state) {
          if (state is ResultLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ResultError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: ColorManager.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error Loading Results',
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: getMediumStyle(
                      color: ColorManager.grey,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ResultCubit>().fetchQuestions();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorManager.blue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Try Again',
                      style: getSemiBoldStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
         
         
          }

          if (state is QuestionsLoaded && state.questions.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.quiz_outlined,
                    size: 64,
                    color: ColorManager.blue,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Results Yet',
                    style: getBoldStyle(
                      color: ColorManager.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Take some exams to see your results here',
                    style: getMediumStyle(
                      color: ColorManager.grey,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<ResultCubit>().fetchQuestions();
            },
            color: ColorManager.blue,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state is QuestionsLoaded ? state.questions.length : 0,
              itemBuilder: (context, index) {
                return ResultContainer(
                  context: context,
                  index: index,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
