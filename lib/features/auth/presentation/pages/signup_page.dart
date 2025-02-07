// features/auth/presentation/pages/signup_page.dart
import 'package:exam_app/core/functions/email_validate.dart';
import 'package:exam_app/core/functions/firstname_validate.dart';
import 'package:exam_app/core/functions/lastname_validate.dart';
import 'package:exam_app/core/functions/navigation.dart';
import 'package:exam_app/core/functions/password_validate.dart';
import 'package:exam_app/core/functions/phonenumber_validate.dart';
import 'package:exam_app/core/functions/username_validate.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/presentation/pages/forgetpassword_page.dart';
import 'package:exam_app/features/auth/presentation/pages/login_page.dart';
import 'package:exam_app/features/auth/presentation/widgets/remember_me_widget.dart';
import 'package:exam_app/features/profile/presentation/profile_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //form key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //userName & firstName& lastName &E-mail & password & ConfirmPassword & phoneNumber
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

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
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Gap(32.h),

              //username
              CustomTextFormField(
                label: 'User name',
                hint: 'Enter your user name',
                controller: userNameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your user name';
                  } else if (value.length < 8) {
                    return 'username must be at least 8 characters';
                  } else if (!userNAmeValidation(value)) {
                    return 'enter valid user name';
                  } else {
                    return null;
                  }
                },
              ),
              Gap(24.h),

              //first name & last name
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: 'First name',
                      hint: 'Enter your first name',
                      controller: firstNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your first name';
                        } else if (!firstNAmeValidation(value)) {
                          return 'enter valid first name';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CustomTextFormField(
                        label: 'Last name',
                        hint: 'Enter your last name',
                        controller: lastNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter your last name';
                          } else if (!lastNAmeValidation(value)) {
                            return 'enter valid last name';
                          } else {
                            return null;
                          }
                        }),
                  ),
                ],
              ),
              Gap(24.h),

              //email
              CustomTextFormField(
                label: 'Email',
                hint: 'Enter you E-mail',
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your email';
                  } else if (!emailValidate(value)) {
                    return 'enter valid email';
                  } else {
                    return null;
                  }
                },
              ),
              Gap(24.h),

              //password and confirm password
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      label: 'Password',
                      hint: 'Enter password',
                      isPass: true,
                      controller: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your password';
                        } else if (!passwordValidation(value)) {
                          return 'enter valid password';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: CustomTextFormField(
                      label: 'Confirm Password',
                      hint: 'Confirm password',
                      isPass: true,
                      controller: confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your confirm password';
                        } else if (value != passwordController.text) {
                          return 'password not match';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ],
              ),
              Gap(24.h),

              //phone number
              CustomTextFormField(
                label: 'Phone number',
                hint: 'Enter phone number',
                controller: phoneNumberController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your phone number';
                  } else if (!phoneNumberValidation(value)) {
                    return 'enter valid phone number';
                  } else {
                    return null;
                  }
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
              SizedBox(height: 24.h),

              //signUp button
              CustomElevatedButton(
                title: 'SignUp',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    push(context, ProfilePage());
                  }
                },
              ),
              SizedBox(height: 16.h),

              //already have an account
              RichText(
                text: TextSpan(
                  style: getRegularStyle(
                      color: ColorManager.black, fontSize: 16.sp),
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
      ),
    );
  }
}
