// core/app_data/local_storage/hive_application_storage.dart
import 'package:exam_app/features/explore/data/models/questions_response/question_model.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HiveApplicationStorage {
  static late Box userBox;
  static late Box<QuestionModelHive> questionBox;

  static String? userID;
  static String? examId;

  //initial method to initialize the application storage
  static init() {
    userBox = Hive.box('user');
    questionBox = Hive.box('question');
  }

  //method to save user data
  static cachedData(String key, dynamic value) {
    userBox.put(key, value);
  }

  //method to get user data
  static getData(String key) {
    return userBox.get(key);
  }

  //method to save question data
  static cachedQuestion(String key, QuestionModelHive value) {
    questionBox.put(key, value);
  }

  //method to get question data
  static QuestionModelHive? getQuestion(String key) {
    return questionBox.get(key);
  }
}
