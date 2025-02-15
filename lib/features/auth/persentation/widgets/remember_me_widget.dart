// features/auth/persentation/widgets/remember_me_widget.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/style_manager.dart';
import 'package:flutter/material.dart';

class RememberMeWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const RememberMeWidget({
    super.key,
    required this.onChanged,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          
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
