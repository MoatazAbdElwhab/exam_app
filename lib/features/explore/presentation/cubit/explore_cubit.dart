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
    // Cache exam ID in both Hive and static variable
    getIt<LocalStorageClient>().cacheUserData('examID', examID);

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
        final userId = getIt<LocalStorageClient>().getUserData('userID');
        final examId = getIt<LocalStorageClient>().getUserData('examID');

        if (userId != null && examId != null) {
          for (var i = 0; i < selectAnswersMap.length; i++) {
            final question = questionList[i];
            final userAnswer = selectAnswersMap[i]!.correct;
            final questionKey = '${userId}_${examId}_${question.id}';
            
            getIt<LocalStorageClient>().cacheQuestion(
              questionKey,
              QuestionModelHive(
                id: question.id,
                examID: examId,
                questionID: question.id,
                question: question.question,
                answes: question.answers,
                correctAnswer: question.correct,
                userAnswer: userAnswer,
                duration: question.createdAt,
                isCompleted: true,
              ),
            );
            debugPrint('Successfully cached question $i');
          }
        } else {
          debugPrint('Cannot cache answers: userID or examID not found');
        }
      } catch (e) {
        debugPrint('Failed to cache answers: $e');
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
    // for (var i = 0; i < 11; i++) {
    //   final queID = getIt.get<LocalStorageClient>().getData('QuestionID$i');
    //   final chosenQus = getIt.get<LocalStorageClient>().getData('Chosen$i');

    //   print('queID success $queID');
    //   print('chosenQus success $chosenQus');
    // }
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
