// features/result/presentation/widget/result_container.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/features/result/presentation/cubit/result_cubit.dart';
import 'package:exam_app/features/result/presentation/pages/result_details.dart';

class ResultContainer extends StatelessWidget {
  final BuildContext context;
  final int index;

  const ResultContainer({
    Key? key,
    required this.context,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResultCubit, ResultState>(
      builder: (context, state) {
        if (state is QuestionsLoaded) {
          final question = state.questions[index];
          final isAnswered = question.answers.any((a) => a.key == question.correct);

          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultDetails(
                    questionModel: question,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${index + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subject: ${question.subject.name}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: isAnswered
                              ? Colors.green.withOpacity(0.1)
                              : Colors.orange.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          isAnswered ? 'Answered' : 'Not Answered',
                          style: TextStyle(
                            fontSize: 12,
                            color: isAnswered ? Colors.green : Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}