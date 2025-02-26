import 'package:exam_app/core/logger/app_logger.dart';
import 'package:exam_app/core/routes/navigator_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../resources/color_manager.dart';
import '../resources/styles_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? style;
  final List<Widget>? actions;
  final bool canPop;

  const CustomAppBar({
    super.key,
    required this.title,
    this.canPop = false,
    this.actions,
    this.style,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: canPop,
      leading: canPop
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
        title,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: style ??
            getMediumStyle(
              fontSize: 20.sp,
              color: ColorManager.black,
            ),
      ),
      actions: actions,
      centerTitle: false,
    );
  }
}
