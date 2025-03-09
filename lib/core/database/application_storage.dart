// core/database/application_storage.dart
import 'package:exam_app/core/database/question_model.dart';
import 'package:hive/hive.dart';

class ApplicationStorage {
  static late Box userBox;
  static late Box<QuestionModel> questionBox;

  static  String userID="1";

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
  static cachedQuestion(String key, QuestionModel value) {
    questionBox.put(key, value);
  }

  //method to get question data
  static QuestionModel? getQuestion(String key) {
    return questionBox.get(key);
  }
}
