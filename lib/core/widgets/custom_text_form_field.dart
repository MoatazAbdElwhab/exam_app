// core/widgets/custom_text_form_field.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isPass;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

   CustomTextFormField({
    super.key,
    required this.label,
    required this.hint,
    this.isPass = false,
    this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
       controller: controller,
       validator: validator,
      style: getRegularStyle(color: ColorManager.black, fontSize: 16.sp),
      obscureText: isPass,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 16, top: 18, bottom: 18),
        hintText: hint,
        hintStyle: getRegularStyle(
          color: ColorManager.placeholder,
          fontSize: 14,
        ),
        label: Text(label),
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
