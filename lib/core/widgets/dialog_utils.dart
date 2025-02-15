// core/widgets/dialog_utils.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';

@singleton
class DialogUtils {
  void showSnackBar({
    required String message,
    required BuildContext context,
    Color textColor = Colors.white,
    Color backgroundColor = Colors.black,
    Duration duration = const Duration(seconds: 5),
    IconData icon = Icons.info_outline,
    String? actionLabel,
    VoidCallback? onActionPressed,
  }) {
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(
                icon,
                color: textColor,
                size: 24.sp,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor.withOpacity(0.8),
          duration: duration,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 8,
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          action: actionLabel != null && onActionPressed != null
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: textColor,
                  onPressed: onActionPressed,
                )
              : null,
        ),
      );
  }
}
