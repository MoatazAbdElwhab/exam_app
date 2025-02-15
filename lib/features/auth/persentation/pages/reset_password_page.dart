// features/auth/persentation/pages/reset_password_page.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/style_manager.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  String? confirmPasswordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      // Proceed with password reset
      print('Password reset successful');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Password', canPop: true),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Reset password',
                        style: getMediumStyle(
                          color: ColorManager.black,
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Password must not be empty and must contain',
                        style: getRegularStyle(
                          color: ColorManager.grey,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        '6 characters with upper case letter and one',
                        style: getRegularStyle(
                          color: ColorManager.grey,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        'number at least',
                        style: getRegularStyle(
                          color: ColorManager.grey,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 32.h),
                  CustomTextFormField(
                    label: 'New Password',
                    hint: 'Enter your password',
                    controller: passwordController,
                    validator: Validator.passwordValidation,
                    isPass: true,
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormField(
                    label: 'Confirm Password',
                    hint: 'Confirm password',
                    controller: confirmPasswordController,
                    validator: confirmPasswordValidation,
                    isPass: true,
                  ),
                  SizedBox(height: 48.h),
                  CustomElevatedButton(
                    title: 'Continue',
                    onTap: _onSubmit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
