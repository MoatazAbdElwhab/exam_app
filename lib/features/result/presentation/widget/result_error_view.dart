// features/result/presentation/widget/result_error_view.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class ResultErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ResultErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        const    Icon(
              Icons.error_outline,
              size: 64,
              color: ColorManager.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Error Loading Results',
              style: getBoldStyle(
                color: ColorManager.black,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              style: getRegularStyle(
                color: ColorManager.grey,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Retry',
                style: getMediumStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
