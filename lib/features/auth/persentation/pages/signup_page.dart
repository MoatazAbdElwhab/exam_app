// features/auth/persentation/pages/signup_page.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/style_manager.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/persentation/cubit/auth_cubit.dart';
import 'package:exam_app/features/auth/persentation/cubit/auth_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Controllers
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
      appBar: const CustomAppBar(title: 'Sign up', canPop: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                label: 'User name',
                hint: 'Enter your user name',
                controller: userNameController,
                validator: Validator.userNameValidation,
              ),
              SizedBox(height: 16.h),

              // First & Last Name
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
              SizedBox(height: 16.h),

              // Email
              CustomTextFormField(
                label: 'Email',
                hint: 'Enter your email',
                controller: emailController,
                validator: Validator.emailValidate,
              ),
              SizedBox(height: 16.h),

              // Password & Confirm Password
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
                          return 'Please enter your confirm password';
                        } else if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Phone Number
              CustomTextFormField(
                label: 'Phone number',
                hint: 'Enter phone number',
                controller: phoneNumberController,
                validator: Validator.phoneNumberValidation,
              ),
              SizedBox(height: 24.h),

              // SignUp Button
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state.status.isSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Signup successful!')),
                    );

                    Navigator.pushNamed(context, Routes.profile);
                  } else if (state.status.isFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text(state.errorMessage ?? 'An error occurred')),
                    );
                  }
                },
                builder: (context, state) {
                  return CustomElevatedButton(
                    title: state.status.isLoading ? 'Signing up...' : 'Signup',
                    onTap: state.status.isLoading
                        ? () {} // Provide an empty function instead of null
                        : () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthCubit>().signUp(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    userName: userNameController.text,
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    phone: phoneNumberController.text,
                                  );
                            }
                          },
                  );
                },
              ),
              SizedBox(height: 16.h),

              // Already have an account?
              Center(
                child: RichText(
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
                          ..onTap = () => Navigator.pop(context),
                        // ..onTap = () => Routes.login,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
