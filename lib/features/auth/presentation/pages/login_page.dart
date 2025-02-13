import 'package:exam_app/core/di/injectable.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/core/widgets/dialog_utils.dart';
import 'package:exam_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:exam_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:exam_app/features/auth/presentation/widgets/remember_me_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool? value = false;
  CustomElevatedButton? customElevatedButton;

  @override
  void dispose() {
    context.read<AuthCubit>().disposeSignInControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Scaffold(
      appBar: const CustomAppBar(title: 'Login'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state.status.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Form(
                onChanged: () {
                  if(customElevatedButton != null) {
                    customElevatedButton!.isFormValid(context
                      .read<AuthCubit>()
                      .isFormValid(isLogin: true));
                  }
                  // var emailValidation = Validator.emailValidate(emailController.text.trim());
                  //  var passwordV = Validator.passwordValidation(passwordController.text.trim());
                  //  if(customElevatedButton != null && emailValidation == null
                  //  && passwordV == null){
                  //    customElevatedButton!.setColor(true);
                  //  }else {
                  //    customElevatedButton!.setColor(false);
                  //  }
                },
                key: formKey,
                child: Column(
                  children: [
                    Gap(32.h),
                    CustomTextFormField(
                      label: 'Email',
                      hint: 'Enter you email',
                      controller:
                      cubit.loginEmailController,
                      validator: Validator.emailValidate,
                      // onChanged: (val) {
                      //   if (customElevatedButton != null) {
                      //     emailValidationReturn =
                      //         Validator.emailValidate(emailController.text.trim());
                      //     if (emailValidationReturn == null &&
                      //         passwordValidationReturn == null) {
                      //       customElevatedButton!.setColor(true);
                      //     } else {
                      //       customElevatedButton!.setColor(false);
                      //     }
                      //   }
                      // },
                    ),
                    Gap(24.h),
                    CustomTextFormField(
                      label: 'Password',
                      hint: 'Enter you password',
                      isPass: true,
                      controller:
                      cubit.loginPasswordController,
                      validator: Validator.passwordValidation,
                      // onChanged: (val) {
                      //   passwordValidationReturn = Validator.passwordValidation(
                      //       passwordController.text.trim());
                      //   if (passwordValidationReturn == null &&
                      //       emailValidationReturn == null) {
                      //     customElevatedButton!.setColor(true);
                      //   } else {
                      //     customElevatedButton!.setColor(false);
                      //   }
                      // },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RememberMeWidget(
                          value: value,
                          onChanged: onChanged,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Routes.forgetPassword);
                          },
                          child: Text(
                            'Forget password?',
                            style: getTextUnderLine(color: ColorManager.black),
                          ),
                        )
                      ],
                    ),
                    Gap(24.h),
                    customElevatedButton = CustomElevatedButton(
                      title: 'Login',
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          // if (customElevatedButton != null) {
                          //   customElevatedButton!.setColor(true);
                          // }
                          await cubit.signIn();
                          // Navigator.pushNamed(context, Routes.profile);
                        }
                        // else {
                        //   if (customElevatedButton != null) {
                        //     customElevatedButton!.setColor(false);
                        //   }
                        // }
                      },
                    ),
                    Gap(16.h),
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
                                Navigator.pushNamed(context, Routes.signup);
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
          listener: (BuildContext context, AuthState state) {
            if (state.status.isLoginSuccess) {
              Navigator.of(context).pushNamed(Routes.profile);
            } else if (state.errorMessage != null) {
              getIt<DialogUtils>().showSnackBar(
                  textColor: Colors.red,
                  message: state.errorMessage!,
                  context: context);
            }else if (state.successMessage != null) {
              getIt<DialogUtils>().showSnackBar(
                  textColor: Colors.green,
                  message: state.successMessage!,
                  context: context);
            }
          },
        ),
      ),
    );
  }

  onChanged(bool? newValue) {
    value = newValue;
  }
}
