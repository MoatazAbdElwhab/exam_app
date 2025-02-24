// features/result/presentation/pages/result_page.dart
import 'package:exam_app/features/result/domain/result_repository/result_repository.dart';
import 'package:exam_app/features/result/presentation/cubit/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/result/presentation/widget/result_container.dart';

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
      body: BlocBuilder<ResultCubit, ResultState>(
        builder: (context, state) {
          if (state is QuestionsLoaded) {
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
          } else if (state is ResultError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
