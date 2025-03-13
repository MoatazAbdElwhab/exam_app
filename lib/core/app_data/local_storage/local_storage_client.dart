// core/app_data/local_storage/local_storage_client.dart
import 'dart:ffi';

import 'package:exam_app/core/app_data/local_storage/hive_application_storage.dart';
import 'package:exam_app/features/explore/data/models/questions_response/question_model.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../error_handling/exceptions/local_storage_exception.dart';
import '../../logger/app_logger.dart';

@singleton
class LocalStorageClient {
  SharedPreferences sharedPreferences;
  FlutterSecureStorage secureStorage;
  HiveApplicationStorage hiveApplicationStorage;

  LocalStorageClient(
    this.sharedPreferences,
    this.secureStorage,
    this.hiveApplicationStorage,
  );

   Future<bool>? saveData(String key, String value) async {
    try {
      return await sharedPreferences.setString(key, value);
    } catch (e) {
      throw LocalStorageException('Failed to save data: ${e.toString()}');
    }
  }

  String? getData(String key) {
    try {
      Log.d('getting $key');
      return sharedPreferences.getString(
        key,
      );
    } catch (e) {
      throw LocalStorageException('Failed to get data: ${e.toString()}');
    }
  }
   Future<void> saveSecuredData(String key, String value) async {
    try {
      Log.d('saving $key');
      return await secureStorage.write(key: key, value: value);
    } catch (e) {
      throw LocalStorageException('Failed to save data: ${e.toString()}');
    }
  }

  Future<String?> getSecuredData(String key) async {
    try {
      Log.d('getting $key');
      return await secureStorage.read(key: key);
    } catch (e) {
      throw LocalStorageException('Failed to get data: ${e.toString()}');
    }
  }

  Future<void>? deleteData(String key) async {
    try {
      await sharedPreferences.remove(key);
    } catch (e) {
      throw LocalStorageException('Failed to delete data: ${e.toString()}');
    }
  }


    Future<void>? deleteSecuredData(String key) async {
    try {
      Log.d('deleting $key');
      await secureStorage.delete(key: key);
    } catch (e) {
      throw LocalStorageException('Failed to delete data: ${e.toString()}');
    }
  }

  bool? getRememberMe() {
    try {
      bool? rememberMe = sharedPreferences.getBool('rememberUser');
      Log.i('got rememberMe with $rememberMe');
      return rememberMe;
    } catch (e) {
      Log.e(e.toString());
      throw LocalStorageException('Failed to get data: ${e.toString()}');
    }
  }

  Future<void> saveRememberMe(bool rememberMe) async {
    try {
      Log.d('saving rememberMe with $rememberMe');
      await sharedPreferences.setBool('rememberUser', rememberMe);
    } catch (e) {
      throw LocalStorageException('Failed to save data: ${e.toString()}');
    }
  }

  // Hive methods for user data
  Future<void> cacheUserData(String key, dynamic value) async {
    try {
      Log.d('Caching user data for key: $key');
       HiveApplicationStorage.cachedData(key, value);
    } catch (e) {
      debugPrint('Error caching user data: $e');
      throw LocalStorageException('Failed to cache user data: ${e.toString()}');
    }
  }

  dynamic getUserData(String key) {
    try {
      Log.d('Getting user data for key: $key');
      final data = HiveApplicationStorage.getData(key);
      debugPrint('Retrieved user data for $key: $data');
      return data;
    } catch (e) {
      debugPrint('Error getting user data: $e');
      throw LocalStorageException('Failed to get user data: ${e.toString()}');
    }
  }

  // Hive methods for questions
  Future<void> cacheQuestion(String key, QuestionModelHive value) async {
    try {
      Log.d('Caching question for key: $key');
      await HiveApplicationStorage.cachedQuestion(key, value);
      debugPrint('Successfully cached question for key: $key');
    } catch (e) {
      debugPrint('Error caching question: $e');
      throw LocalStorageException('Failed to cache question: ${e.toString()}');
    }
  }

  Future<QuestionModelHive?> getQuestion(String key) async {
    try {
      Log.d('Getting question for key: $key');
      final question = await HiveApplicationStorage.getQuestion(key);
      debugPrint('Retrieved question for key: $key');
      return question;
    } catch (e) {
      debugPrint('Error getting question: $e');
      throw LocalStorageException('Failed to get question: ${e.toString()}');
    }
  }

  Future<List<QuestionModelHive>> getAllCachedQuestions() async {
    try {
      Log.d('Getting all cached questions');
      final userId = getUserData('userID');
      final examId = getUserData('examID');
      
      debugPrint('Fetching questions for userID: $userId, examID: $examId');
      
      if (userId == null || examId == null) {
        throw LocalStorageException('No exam results found. Take your first exam to see your results here.');
      }
      
      final questions = await HiveApplicationStorage.getAllQuestions();
      if (questions.isEmpty) {
        throw LocalStorageException('No exam results found. Take your first exam to see your results here.');
      }
      
      debugPrint('Found ${questions.length} cached questions');
      return questions;
    } catch (e) {
      debugPrint('Error getting all cached questions: $e');
      throw LocalStorageException('Failed to get cached questions: ${e.toString()}');
    }
  }

  Future<List<String>> getAllQuestionKeys() async {
    try {
      Log.d('Getting all question keys');
      final userId = getUserData('userID');
      final examId = getUserData('examID');
      
      if (userId == null || examId == null) {
        throw LocalStorageException('No exam results found. Take your first exam to see your results here.');
      }
      
      final keys = await HiveApplicationStorage.getAllQuestionKeys();
      debugPrint('Found ${keys.length} question keys');
      return keys;
    } catch (e) {
      debugPrint('Error getting question keys: $e');
      throw LocalStorageException('Failed to get question keys: ${e.toString()}');
    }
  }
}
