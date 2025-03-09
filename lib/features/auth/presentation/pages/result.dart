// features/auth/presentation/pages/result.dart
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Result',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: const [
            Text(""),
          ],
        ),
      ),
    );
  }
}
