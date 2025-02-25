// features/result/presentation/pages/results_page.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/result/presentation/widget/result_container.dart';

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
        title: 'Result',
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
                  Text(
                    state.message,
                    style:const TextStyle(color: ColorManager.error),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<ResultCubit>().fetchQuestions();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is QuestionsLoaded) {
            if (state.questions.isEmpty) {
              return const Center(
                child: Text('No questions available'),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: state.questions.length,
              itemBuilder: (context, index) {
                return ResultContainer(
                  context: context,
                  index: index,
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16);
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
