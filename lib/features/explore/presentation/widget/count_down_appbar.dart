import 'dart:async';

import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/icon_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountDownAppbar extends StatefulWidget implements PreferredSizeWidget {
  final int minutes;

  const CountDownAppbar({super.key, required this.minutes});

  @override
  State<CountDownAppbar> createState() => _CountDownAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}

class _CountDownAppbarState extends State<CountDownAppbar> {
  late int remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    remainingSeconds = widget.minutes * 60;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingSeconds > 0) {
          remainingSeconds--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  String get formattedTime {
    int mins = remainingSeconds ~/ 60;
    int secs = remainingSeconds % 60;
    return '$mins:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      leading: IconButton(
        padding: EdgeInsets.zero,
        icon: Icon(
          Icons.arrow_back_ios_new,
          size: 24.w,
          color: ColorManager.black,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      leadingWidth: 40.w,
      title: Text(
        'Exam',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: getMediumStyle(color: ColorManager.black, fontSize: 20.sp),
      ),
      actions: [
        Image.asset(
          IconManager.timerPng,
          height: 30,
          width: 30,
        ),
        const SizedBox(width: 4),
        Text(
          formattedTime,
          style: getRegularStyle(
            color: (remainingSeconds ~/ 60 < 5)
                ? ColorManager.error
                : ColorManager.success,
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 12),
      ],
    );
  }
}
