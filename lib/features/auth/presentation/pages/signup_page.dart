import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_app_bar.dart';

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
  void dispose() {
    context.read<AuthCubit>().disposeSignUpControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Sign up',
        canPop: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Form(
            key: formKey,
            child: Column(
              spacing: 24.h,
              children: [
                //username
                CustomTextFormField(
                  label: 'User name',
                  hint: 'Enter your user name',
                  controller: userNameController,
                  validator: Validator.userNameValidation,
                ),

                //first name & last name
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        label: 'First name',
                        hint: 'Enter your first name',
                        controller: firstNameController,
                        validator: Validator.firstNameValidation,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: CustomTextFormField(
                        label: 'Last name',
                        hint: 'Enter your last name',
                        controller: lastNameController,
                        validator: Validator.lastNameValidation,
                      ),
                    ),
                  ],
                ),
                //email
                CustomTextFormField(
                  label: 'Email',
                  hint: 'Enter you E-mail',
                  controller: emailController,
                  validator: Validator.emailValidate,
                ),

                //password and confirm password
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        label: 'Password',
                        hint: 'Enter password',
                        isPass: true,
                        controller: passwordController,
                        validator: Validator.passwordValidation,
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

                //phone number
                CustomTextFormField(
                  label: 'Phone number',
                  hint: 'Enter phone number',
                  controller: phoneNumberController,
                  validator: Validator.phoneNumberValidation,
                ),

                SizedBox(height: 24.h),

                //signUp button
                CustomElevatedButton(
                  title: 'Signup',
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                     await context.read<AuthCubit>().signUp(
                          email: emailController.text,
                          password: passwordController.text,
                          userName: userNameController.text,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          phone: phoneNumberController.text);
                      // Navigator.pushNamed(context, Routes.profile);
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
                            Navigator.pop(context);
                          },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
