import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final ValueNotifier<bool> _isValidNotifier = ValueNotifier(false);

  CustomElevatedButton({
    super.key,
    required this.title,
    this.height,
    this.width,
    required this.onTap,
    this.backgroundColor,
  });

  void isFormValid(bool isValid) {
    if (_isValidNotifier.value != isValid) {
      _isValidNotifier.value = isValid;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isValidNotifier,
      builder: (_, isValid, child) {
        return SizedBox(
          height: height ?? 48.h,
          width: width ?? double.infinity,
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor != null
                  ? (isValid ? backgroundColor : Colors.grey)
                  : (isValid ? ColorManager.blue : Colors.grey),
            ),
            child: Text(
              title,
              style: getMediumStyle(
                color: ColorManager.white,
                fontSize: 16.sp,
              ),
            ),
          ),
        );
      },
    );
  }
}
