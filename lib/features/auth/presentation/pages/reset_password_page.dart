import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Password',canPop: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
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
              hint: 'Enter you password',
              controller: passwordController,
              validator: Validator.passwordValidation,
            ),
            SizedBox(height: 24.h),
            CustomTextFormField(
              label: 'Confirm password',
              hint: 'Confirm password',
              controller: confirmPasswordController,
              validator: Validator.passwordValidation,
            ),
            SizedBox(height: 48.h),
            CustomElevatedButton(
              title: 'Continue',
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}
