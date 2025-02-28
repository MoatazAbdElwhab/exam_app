import 'dart:async';

import 'package:exam_app/core/resources/icon_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? style;
  final List<Widget>? actions;
  final bool canPop;
  final int? minutes;

  const CustomAppBar({
    super.key,
    required this.title,
    this.canPop = false,
    this.actions,
    this.style,
    this.minutes,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late int remainingSeconds;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    if (widget.minutes != null) {
      remainingSeconds = widget.minutes! * 60;
      _startTimer();
    }
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
      automaticallyImplyLeading: widget.canPop,
      leading: widget.canPop
          ? IconButton(
              padding: EdgeInsets.zero,
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: 24.w,
                color: ColorManager.black,
              ),
              onPressed: () => Navigator.pop(context),
            )
          : null,
      leadingWidth: 40.w,
      title: Text(
        widget.title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: widget.style ??
            getMediumStyle(
              fontSize: 20.sp,
              color: ColorManager.black,
            ),
      ),
      actions: widget.minutes != null
          ? [
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
            ]
          : widget.actions,
      centerTitle: false,
    );
  }
}
