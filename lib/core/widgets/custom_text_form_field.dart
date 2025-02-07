import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final String hint;
  final bool isPass;

  const CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    this.isPass = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: getRegularStyle(color: ColorManager.black, fontSize: 16.sp),
      obscureText: widget.isPass,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 16, top: 18, bottom: 18),
        hintText: widget.hint,
        hintStyle: getRegularStyle(
          color: ColorManager.placeholder,
          fontSize: 14,
        ),
        label: Text(widget.label),
        labelStyle: getRegularStyle(color: ColorManager.grey),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: ColorManager.black,
          ),
        ),
      ),
    );
  }
}
