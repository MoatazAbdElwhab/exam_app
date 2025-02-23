import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:exam_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/di/injectable.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/dialog_utils.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final AuthCubit cubit;
  late CustomElevatedButton customElevatedButton;

  @override
  void didChangeDependencies() {
    cubit = context.read<AuthCubit>();
    customElevatedButton = CustomElevatedButton(
      title: 'Signup',
      onTap: () async {
        if (formKey.currentState!.validate()) {
          await cubit.signUp();
        }
      },
    );
    super.didChangeDependencies();
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
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (BuildContext context, AuthState state) {
              final dialogUtils = getIt<DialogUtils>();
              if (state.successMessage != null) {
                dialogUtils.showSnackBar(
                    textColor: Colors.green,
                    message: state.successMessage!,
                    context: context);
              }
              if (state.status.isSignUpSuccess) {
                Navigator.of(context).pushNamed(Routes.profile);
              } else if (state.errorMessage != null) {
                getIt<DialogUtils>().showSnackBar(
                    textColor: Colors.red,
                    message: state.errorMessage!,
                    context: context);
              } else if (state.successMessage != null) {
                getIt<DialogUtils>().showSnackBar(
                    textColor: Colors.green,
                    message: state.successMessage!,
                    context: context);
              }
            },
            builder: (context, state) => state.status.isLoading
                ? const Center(child: CircularProgressIndicator())
                : Form(
                    onChanged: () {
                      customElevatedButton
                          .isFormValid(cubit.isFormValid(isLogin: false));
                    },
                    key: formKey,
                    child: Column(
                      // spacing: 24.h,
                      children: [
                        //username
                        CustomTextFormField(
                          label: 'User name',
                          hint: 'Enter your user name',
                          controller: cubit.signUpUserNameController,
                          validator: Validator.userNameValidation,
                        ),

                        //first name & last name
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                label: 'First name',
                                hint: 'Enter your first name',
                                controller: cubit.signUpFirstNameController,
                                validator: Validator.firstNameValidation,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: CustomTextFormField(
                                label: 'Last name',
                                hint: 'Enter your last name',
                                controller: cubit.signUpLastNameController,
                                validator: Validator.lastNameValidation,
                              ),
                            ),
                          ],
                        ),
                        //email
                        CustomTextFormField(
                          label: 'Email',
                          hint: 'Enter you E-mail',
                          controller: cubit.signUpEmailController,
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
                                controller: cubit.signUpPasswordController,
                                validator: Validator.passwordValidation,
                              ),
                            ),
                            SizedBox(width: 16.w),
                            Expanded(
                              child: CustomTextFormField(
                                label: 'Confirm Password',
                                hint: 'Confirm password',
                                isPass: true,
                                controller:
                                    cubit.signUpConfirmPasswordController,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please enter your confirm password';
                                  } else if (value !=
                                      cubit.signUpPasswordController.text) {
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
                          controller: cubit.signUpPhoneNumberController,
                          validator: Validator.phoneNumberValidation,
                        ),

                        SizedBox(height: 24.h),

                        //signUp button
                        customElevatedButton,
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
      ),
    );
  }
}
