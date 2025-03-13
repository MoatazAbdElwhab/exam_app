// features/explore/presentation/cubit/explore_cubit.dart
import 'package:exam_app/core/app_data/local_storage/local_storage_client.dart';
import 'package:exam_app/core/di/injectable.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/widgets/dialog_utils.dart';
import 'package:exam_app/features/explore/data/models/answers_model/select_answer_model.dart';
import 'package:exam_app/features/explore/data/models/answers_model/select_answers_model.dart';
import 'package:exam_app/features/explore/data/models/exam_response/exam_model.dart';
import 'package:exam_app/features/explore/data/models/questions_response/question_model.dart';
import 'package:exam_app/features/explore/data/models/subjects_response/subject_model.dart';
import 'package:exam_app/features/explore/data/repo/explore_repo_impl.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'explore_state.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit(this._exploreRepoImpl) : super(ExploreInitial()) {
    getSubjects();
  }

  final ExploreRepoImpl _exploreRepoImpl;
  List<QuestionModel> questionList = [];
  Map<int, SelectAnswerModel> selectAnswersMap = {};
  int activeQuestion = 0;
  String? selectedAnswer;

  Future<void> getSubjects() async {
    emit(GetSubjetcsLoading());
    final result = await _exploreRepoImpl.getSubjects();
    result.fold(
      (fail) => emit(GetSubjetcsFail(fail.toString())),
      (subjects) => emit(GetSubjetcsSuccess(subjects)),
    );
  }

  Future<void> getAllExamOnSubject(String subjectID) async {
    emit(GetExamsLoading());
    final result = await _exploreRepoImpl.getAllExamOnSubject(subjectID);
    result.fold(
      (fail) => emit(GetExamsFail(fail.toString())),
      (exams) => emit(GetExamsSuccess(exams)),
    );
  }

  Future<void> getAllQuestionsOnExam(String examID) async {
    emit(GetQuestionsLoading());
    
    // Cache exam ID for this session
    final storageClient = getIt<LocalStorageClient>();
    await storageClient.cacheUserData('examID', examID);

    final result = await _exploreRepoImpl.getAllQuestionsOnExam(examID);
    result.fold(
      (fail) => emit(GetQuestionsFail(fail.toString())),
      (questions) {
        questionList = questions;
        emit(GetQuestionsSuccess(questions));
      },
    );
  }

  void onChangeSelectedAnswer(String? value) {
    selectedAnswer = value;
    emit(ChangeAnswer());
  }

  Future<void> nextQuestion(BuildContext context) async {
    if (selectedAnswer == null) {
      getIt<DialogUtils>().showSnackBar(
        textColor: ColorManager.error,
        message: 'Choose an answer',
        context: context,
      );
      return;
    }

    selectAnswersMap[activeQuestion] = SelectAnswerModel(
      questionId: questionList[activeQuestion].id,
      correct: selectedAnswer!,
    );

    if (activeQuestion + 1 == questionList.length) {
      // First cache answers through LocalStorageClient
      try {
        final storageClient = getIt<LocalStorageClient>();
        final userId = storageClient.getUserData('userID');
        final examId = storageClient.getUserData('examID');

        if (userId != null && examId != null) {
          for (var i = 0; i < selectAnswersMap.length; i++) {
            final question = questionList[i];
            final userAnswer = selectAnswersMap[i]!.correct;
            final questionKey = '${userId}_${examId}_${question.id}';
            
            debugPrint('Caching question with key: $questionKey');
            await storageClient.cacheQuestion(
              questionKey,
              QuestionModelHive(
                id: questionKey, // Use the full key as the ID for proper filtering
                examID: examId,
                questionID: question.id,
                question: question.question,
                answes: question.answers.map((answer) => answer.answer).toList(),
                correctAnswer: question.correct,
                userAnswer: userAnswer,
                duration: DateTime.now().difference(question.createdAt).inSeconds,
                isCompleted: true,
              ),
            );
            debugPrint('Successfully cached question $i');
          }
        } else {
          debugPrint('Cannot cache answers: userID or examID not found');
          getIt<DialogUtils>().showSnackBar(
            textColor: ColorManager.error,
            message: 'Please login to save your exam results',
            context: context,
          );
          return;
        }
      } catch (e) {
        debugPrint('Failed to cache answers: $e');
        getIt<DialogUtils>().showSnackBar(
          textColor: ColorManager.error,
          message: 'Failed to save exam results. Please try again.',
          context: context,
        );
        return;
      }

      // Then show completion message
      getIt<DialogUtils>().showSnackBar(
        textColor: ColorManager.success,
        message: 'Complete exam',
        context: context,
      );

      // Finally check answers and navigate
      await checkQuestions(context);
      return;
    }

    activeQuestion++;
    bool lateAnswer = selectAnswersMap.containsKey(activeQuestion);
    selectedAnswer = lateAnswer ? selectAnswersMap[activeQuestion]!.correct : null;
    emit(ChangeAnswer());
  }

  void backQuestion() {
    activeQuestion--;
    selectedAnswer = selectAnswersMap[activeQuestion]!.correct;
    emit(ChangeAnswer());
  }

  Future<void> checkQuestions(BuildContext context) async {
    List<SelectAnswerModel> answers = [];
    selectAnswersMap.forEach((key, value) => answers.add(value));
    
    final result = await _exploreRepoImpl.checkQuestions(
      SelectAnswersModel(answers: answers, time: 20),
    );
    
    result.fold(
      (fail) {
        getIt<DialogUtils>().showSnackBar(
          textColor: ColorManager.error,
          message: fail.toString(),
          context: context,
        );
      },
      (right) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.examScore,
          (route) => false,
          arguments: right,
        );
      },
    );
  }

  void initExam() {
    questionList.clear();
    selectAnswersMap.clear();
    activeQuestion = 0;
    selectedAnswer = null;
  }
}
