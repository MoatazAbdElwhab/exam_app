// features/result/presentation/widget/result_state_handler.dart
import 'package:exam_app/features/result/presentation/cubit/result_state.dart';
import 'package:flutter/material.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/result/presentation/widget/result_error_view.dart';
import 'package:exam_app/features/result/presentation/widget/result_container.dart';
import 'package:exam_app/features/result/presentation/widget/no_exam.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultStateHandler extends StatelessWidget {
  final ResultState state;

  const ResultStateHandler({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    switch (state.status) {
      case ResultStatus.initial:
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorManager.blue),
          ),
        );

      case ResultStatus.loading:
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorManager.blue),
          ),
        );

      case ResultStatus.error:
        return ResultErrorView(
          message: state.errorMessage ?? 'An unexpected error occurred',
          onRetry: () => context.read<ResultCubit>().retryLoading(),
        );

      case ResultStatus.loaded:
        if (state.questions == null || state.questions!.isEmpty) {
          return const NoExam();
        }
        return ResultContainer(
          questions: state.questions!,
          examScore: state.examScore!,
        );
    }
  }
}
