import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/presentation/widgets/remember_me_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Login',
          style: getMediumStyle(fontSize: 20.sp, color: ColorManager.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 32.h),
            const CustomTextFormField(
              label: 'Email',
              hint: 'Enter you email',
            ),
            SizedBox(height: 24.h),
            const CustomTextFormField(
              label: 'Password',
              hint: 'Enter you password',
              isPass: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RememberMeWidget(
                  value: true,
                  onChanged: (p0) {},
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Forget password?',
                    style: getTextUnderLine(color: ColorManager.black),
                  ),
                )
              ],
            ),
            SizedBox(height: 24.h),
            CustomElevatedButton(
              title: 'Login',
              onTap: () {},
            ),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                style:
                    getRegularStyle(color: ColorManager.black, fontSize: 16.sp),
                children: [
                  const TextSpan(text: "Don't have an account? "),
                  TextSpan(
                    text: 'Sign up',
                    style: getTextUnderLine(
                        color: ColorManager.blue, fontSize: 16.sp),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
