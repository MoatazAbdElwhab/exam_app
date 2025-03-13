// features/result/presentation/cubit/result_cubit.dart
import 'package:bloc/bloc.dart';

import 'package:exam_app/features/result/domain/usecases/calculate_cached_exam_score_usecase.dart';
import 'package:exam_app/features/result/domain/usecases/get_cached_exam_questions_usecase.dart';
import 'package:exam_app/features/result/presentation/cubit/result_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResultCubit extends Cubit<ResultState> {
  final GetCachedExamQuestionsUseCase _getCachedExamQuestionsUseCase;
  final CalculateCachedExamScoreUseCase _calculateCachedExamScoreUseCase;

  ResultCubit(
    this._getCachedExamQuestionsUseCase,
    this._calculateCachedExamScoreUseCase,
  ) : super(const ResultState()) {
    loadExamResults();
  }

  Future<void> loadExamResults() async {
    try {
      final questionsResult = await _getCachedExamQuestionsUseCase();
      
      await questionsResult.fold(
        (error) async {
          emit(state.copyWith(
            status: ResultStatus.error,
            errorMessage: error.message,
          ));
        },
        (questions) async {
          final scoreResult = await _calculateCachedExamScoreUseCase(questions);
          
          scoreResult.fold(
            (error) {
              emit(state.copyWith(
                status: ResultStatus.error,
                errorMessage: error.message,
              ));
            },
            (score) {
              emit(state.copyWith(
                status: ResultStatus.loaded,
                questions: questions,
                examScore: score,
                errorMessage: null,
              ));
            },
          );
        },
      );
    } catch (e) {
      emit(state.copyWith(
        status: ResultStatus.error,
        errorMessage: 'Failed to load exam results: ${e.toString()}',
      ));
    }
  }

  Future<void> retryLoading() async {
    await loadExamResults();
  }
}
