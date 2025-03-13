// core/app_data/local_storage/hive_application_storage.dart
import 'package:exam_app/core/logger/app_logger.dart';
import 'package:exam_app/features/explore/data/models/questions_response/question_model.dart';
import 'package:exam_app/features/result/data/data_models/hive_model/question_model.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HiveApplicationStorage {
  static Box? userBox;
  static Box<QuestionModelHive>? questionBox;

  static Future<void> init() async {
    try {
      // Initialize Hive first
      await Hive.initFlutter();
      
      // Register adapters if not already registered
      if (!Hive.isAdapterRegistered(QuestionModelHiveAdapter().typeId)) {
        Hive.registerAdapter(QuestionModelHiveAdapter());
      }
      
      // Open boxes after initialization
      userBox = await Hive.openBox('user');
      questionBox = await Hive.openBox<QuestionModelHive>('question');
      // debugPrint('Successfully initialized Hive boxes');
    } catch (e) {
      // debugPrint('Failed to initialize Hive boxes: $e');
      rethrow;
    }
  }

  static Future<void> ensureBoxesOpen() async {
    try {
      if (!Hive.isBoxOpen('user')) {
        userBox = await Hive.openBox('user');
      }
      if (!Hive.isBoxOpen('question')) {
        questionBox = await Hive.openBox<QuestionModelHive>('question');
      }
    } catch (e) {
      // debugPrint('Failed to ensure boxes are open: $e');
      rethrow;
    }
  }

  static void cachedData(String key, dynamic value) {
    try {
      Log.d('Caching data for key: $key');
      userBox?.put(key, value);
      // debugPrint('Successfully cached data for key: $key');
    } catch (e) {
      // debugPrint('Failed to cache data for key $key: $e');
      rethrow;
    }
  }

  static dynamic getData(String key) {
    try {
      Log.d('Getting data for key: $key');
      final data = userBox?.get(key);
      // debugPrint('Retrieved data for key $key: $data');
      return data;
    } catch (e) {
      // debugPrint('Failed to get data for key $key: $e');
      rethrow;
    }
  }

  static Future<void> cachedQuestion(String key, QuestionModelHive value) async {
    try {
      Log.d('Caching question for key: $key');
      await ensureBoxesOpen();
      
      await questionBox?.put(key, value);
      // debugPrint('Successfully cached question for key: $key');
      
      // Debug: Print all questions after caching
      // final allQuestions = questionBox?.values.toList() ?? [];
      // debugPrint('Total questions in box: ${allQuestions.length}');
      // for (var q in allQuestions) {
      //   debugPrint('Question ID: ${q.id}');
      // }
    } catch (e) {
      // debugPrint('Failed to cache question for key $key: $e');
      rethrow;
    }
  }

  static Future<QuestionModelHive?> getQuestion(String key) async {
    try {
      Log.d('Getting question for key: $key');
      await ensureBoxesOpen();
      
      final question = questionBox?.get(key);
      // debugPrint('Retrieved question for key $key: ${question?.id}');
      return question;
    } catch (e) {
      // debugPrint('Failed to get question for key $key: $e');
      rethrow;
    }
  }

  static Future<List<QuestionModelHive>> getAllQuestions() async {
    try {
      Log.d('Getting all questions');
      await ensureBoxesOpen();

      final userId = getData('userID');
      final examId = getData('examID');

      if (userId == null || examId == null) {
        // debugPrint('Missing userID ($userId) or examID ($examId)');
        return [];
      }

      final pattern = '${userId}_${examId}_';
      // debugPrint('Looking for questions with pattern: $pattern');
      
      final allQuestions = questionBox?.values.toList() ?? [];
      // debugPrint('Total questions in box: ${allQuestions.length}');
      // for (var q in allQuestions) {
      //   debugPrint('Found question with ID: ${q.id}');
      // }

      final questions = allQuestions.where((q) => q.id.startsWith(pattern)).toList();
      // debugPrint('Found ${questions.length} questions matching pattern: $pattern');
      // for (var q in questions) {
      //   debugPrint('Matching question ID: ${q.id}');
      // }
      return questions;
    } catch (e) {
      // debugPrint('Failed to get all questions: $e');
      return [];
    }
  }

  static Future<List<String>> getAllQuestionKeys() async {
    try {
      Log.d('Getting all question keys');
      await ensureBoxesOpen();

      final userId = getData('userID');
      final examId = getData('examID');

      if (userId == null || examId == null) {
        // debugPrint('Missing userID ($userId) or examID ($examId)');
        return [];
      }

      final pattern = '${userId}_${examId}_';
      final keys = questionBox?.keys
          .map((k) => k.toString())
          .where((k) => k.startsWith(pattern))
          .toList() ?? [];

      // debugPrint('Found ${keys.length} keys matching pattern: $pattern');
      // for (var key in keys) {
      //   debugPrint('Key: $key');
      // }
      return keys;
    } catch (e) {
      // debugPrint('Failed to get all question keys: $e');
      return [];
    }
  }
}
