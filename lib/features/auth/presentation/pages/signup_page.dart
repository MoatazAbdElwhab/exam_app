// features/auth/presentation/pages/signup_page.dart
import 'package:exam_app/core/functions/navigation.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/presentation/pages/forgetpassword_page.dart';
import 'package:exam_app/features/auth/presentation/pages/login_page.dart';
import 'package:exam_app/features/auth/presentation/widgets/remember_me_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'SignUp',
          style: getMediumStyle(fontSize: 20.sp, color: ColorManager.black),
        ),
      ),
      //body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //SizedBox(height: 32.h),
            Gap(32.h),

            //username
             CustomTextFormField(
              label: 'User name',
              hint: 'Enter your user name',
            ),
            // SizedBox(height: 24.h),
            Gap(24.h),

            //first name & last name
            Row(
              children: [
                 Expanded(
                  child: CustomTextFormField(
                    label: 'First name',
                    hint: 'Enter your first name',
                  ),
                ),
                SizedBox(width: 16.w),
                 Expanded(
                  child: CustomTextFormField(
                    label: 'Last name',
                    hint: 'Enter your last name',
                  ),
                ),
              ],
            ),
            Gap(24.h),

            //email

             CustomTextFormField(
              label: 'Email',
              hint: 'Enter you E-mail',
              isPass: true,
            ),
            Gap(24.h),

            //password and confirm password

            Row(
              children: [
                 Expanded(
                  child: CustomTextFormField(
                    label: 'Password',
                    hint: 'Enter password',
                  ),
                ),
                SizedBox(width: 16.w),
                 Expanded(
                  child: CustomTextFormField(
                    label: 'Confirm Password',
                    hint: 'Confirm password',
                  ),
                ),
              ],
            ),
            Gap(24.h),

            //phone number
             CustomTextFormField(
              label: 'Phone number',
              hint: 'Enter phone number',
            ),

            //forgetpassword
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RememberMeWidget(
                  value: true,
                  onChanged: (p0) {},
                ),
                GestureDetector(
                  onTap: () {
                    push(context, ForgetpasswordPage());
                  },
                  child: Text(
                    'Forget password?',
                    style: getTextUnderLine(color: ColorManager.black),
                  ),
                )
              ],
            ),
            SizedBox(height: 24.h),

            //signUp button
            CustomElevatedButton(
              title: 'SignUp',
              onTap: () {},
            ),
            SizedBox(height: 16.h),

            //already have an account
            RichText(
              text: TextSpan(
                style:
                    getRegularStyle(color: ColorManager.black, fontSize: 16.sp),
                children: [
                  const TextSpan(text: "Already have an account? "),
                  TextSpan(
                    text: 'Login',
                    style: getTextUnderLine(
                        color: ColorManager.blue, fontSize: 16.sp),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        push(context, LoginPage());
                      },
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
