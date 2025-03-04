import 'package:flutter/material.dart';

class ResultErrorView extends StatelessWidget {
  final String message;
  
  const ResultErrorView({super.key, required this.message});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message.isNotEmpty ? message : 'Something went wrong'),
    );
  }
}
