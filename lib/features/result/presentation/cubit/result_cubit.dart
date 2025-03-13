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
  ) : super(ResultState.initial()) {
    loadExamResults();
  }

  Future<void> loadExamResults() async {
    try {
      emit(ResultState.loading());

      final questionsResult = await _getCachedExamQuestionsUseCase();
      
      await questionsResult.fold(
        (error) async {
          emit(ResultState.error(error.message));
        },
        (questions) async {
          final scoreResult = await _calculateCachedExamScoreUseCase(questions);
          
          scoreResult.fold(
            (error) {
              emit(ResultState.error(error.message));
            },
            (score) {
              emit(ResultState.loaded(questions: questions, examScore: score));
            },
          );
        },
      );
    } catch (e) {
      emit(ResultState.error('Failed to load exam results: ${e.toString()}'));
    }
  }

  Future<void> retryLoading() async {
    await loadExamResults();
  }
}
