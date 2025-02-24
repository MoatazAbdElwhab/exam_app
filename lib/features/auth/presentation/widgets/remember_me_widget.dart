import 'package:exam_app/core/logger/app_logger.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RememberMeWidget extends StatefulWidget {
  const RememberMeWidget({
    super.key,
  });

  @override
  State<RememberMeWidget> createState() => _RememberMeWidgetState();
}

class _RememberMeWidgetState extends State<RememberMeWidget> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: (newValue) {
            setState(() {
              value = newValue ?? value;
              context.read<AuthCubit>().updateRememberMe(newValue ?? value);
            });
          },
        ),
        Text(
          'Remember me',
          style: getRegularStyle(
            color: ColorManager.black,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
