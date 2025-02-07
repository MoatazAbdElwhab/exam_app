// features/auth/presentation/pages/login_page.dart
import 'package:exam_app/core/functions/navigation.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/icon_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/presentation/pages/forgetpassword_page.dart';
import 'package:exam_app/features/auth/presentation/pages/signup_page.dart';
import 'package:exam_app/features/auth/presentation/widgets/remember_me_widget.dart';
import 'package:exam_app/features/profile/presentation/profile_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //form key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //email & password controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
      //body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Gap(32.h),

              //email
              CustomTextFormField(
                label: 'Email',
                hint: 'Enter you email',
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your email';
                  } else if (!Validator.emailValidate(value)) {
                    return 'enter valid email';
                  } else {
                    return null;
                  }
                },
              ),

              Gap(24.h),

              //password
              CustomTextFormField(
                label: 'Password',
                hint: 'Enter you password',
                isPass: true,
                controller: passwordController,
                validator: (value) {
                  if (Validator.passwordValidation(value)) {
                    return 'The password is not valid';
                  }
                  if (value!.isEmpty) return 'Please enter your password';
                  return null;
                },
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
              Gap(24.h),

              //login button
              CustomElevatedButton(
                title: 'Login',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    push(context, ProfilePage());
                  }
                },
              ),
              Gap(16.h),

              //if you don't have an account
              RichText(
                text: TextSpan(
                  style: getRegularStyle(
                      color: ColorManager.black, fontSize: 16.sp),
                  children: [
                    const TextSpan(text: "Don't have an account? "),
                    TextSpan(
                      text: 'Sign up',
                      style: getTextUnderLine(
                          color: ColorManager.blue, fontSize: 16.sp),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          push(context, SignupPage());
                        },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
