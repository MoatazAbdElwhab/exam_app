// main.dart
import 'package:exam_app/core/database/question_model.dart';
import 'package:exam_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/database/application_storage.dart';


Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  
  // Register adapters before opening boxes
  Hive.registerAdapter(QuestionModelAdapter());
  
  // Open boxes after registering adapters
  await Hive.openBox('user');
  await Hive.openBox<QuestionModel>('question');
  await ApplicationStorage.init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
