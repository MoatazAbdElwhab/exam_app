// features/result/presentation/pages/results_page.dart
import 'package:exam_app/core/di/injectable.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/result/presentation/widget/result_state_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ResultCubit>()..fetchQuestions(),
      child: const ResultPageView(),
    );
  }
}

class ResultPageView extends StatelessWidget {
  const ResultPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Results'),
      body: BlocBuilder<ResultCubit, ResultState>(
        builder: (context, state) => ResultStateHandler(state: state),
      ),
    );
  }
}
