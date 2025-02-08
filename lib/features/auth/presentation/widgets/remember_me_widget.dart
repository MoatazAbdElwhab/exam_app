import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';

class RememberMeWidget extends StatefulWidget {
  final bool? value;
  final Function(bool?) onChanged;
  const RememberMeWidget({
    super.key,
    required this.onChanged,
    required this.value,
  });

  @override
  State<RememberMeWidget> createState() => _RememberMeWidgetState();
}

class _RememberMeWidgetState extends State<RememberMeWidget> {
  late bool? value = widget.value;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: (newValue) {
            value = newValue;
            widget.onChanged(newValue);

            setState(() {});
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
