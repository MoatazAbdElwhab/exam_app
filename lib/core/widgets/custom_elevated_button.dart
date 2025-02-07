// core/widgets/custom_elevated_button.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedButton extends StatelessWidget {
  final String title;
  final double? height;
  final double? width;
  final VoidCallback onTap;
  final Color? backgroundColor;

   const CustomElevatedButton({
    super.key,
    required this.title,
    this.height,
    this.width,
    required this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 48.h,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor:backgroundColor?? ColorManager.blue,
        ),
        child: Text(
          title,
          style: getRegularStyle(
            color: ColorManager.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
