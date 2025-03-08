// core/database/application_storage.dart
import 'package:hive/hive.dart';
class ApplicationStorage {
  static late Box userBox;
  static late Box questionBox;

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
  static cachedQuestion(String key, dynamic value) {
    questionBox.put(key, value);
  }

  //method to get question data 
  static getQuestion(String key) {
    return questionBox.get(key);
  }
}
