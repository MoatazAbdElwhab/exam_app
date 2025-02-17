import 'package:exam_app/core/logger/app_logger.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/di/injectable.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/dialog_utils.dart';
import '../cubit/auth_state.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  CustomElevatedButton? customElevatedButton;

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Password', canPop: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (BuildContext context, AuthState state) {
              final dialogUtilds = getIt<DialogUtils>();
              if (state.errorMessage != null) {
                dialogUtilds.showSnackBar(
                    textColor: Colors.red,
                    message: state.errorMessage!,
                    context: context);
              } else if (state.successMessage != null) {
                dialogUtilds.showSnackBar(
                    textColor: Colors.green,
                    message: state.successMessage!,
                    context: context);
              } else if (state.status.isSuccess && context.mounted) {

                  Navigator.pushNamed(context, Routes.profile);

              }
            },
            builder: (context, state) => state.status.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Form(
                    key: formKey,
                    onChanged: () {
                      if (customElevatedButton != null) {
                        customElevatedButton!.isFormValid(Validator
                                    .passwordValidation(
                                        passwordController.text.trim()) ==
                                null &&
                            Validator.passwordValidation(
                                    confirmPasswordController.text.trim()) ==
                                null &&
                            passwordController.text.trim() ==
                                confirmPasswordController.text.trim());
                      }
                    },
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
                        customElevatedButton = CustomElevatedButton(
                          title: 'Continue',
                          onTap: () async {
                            if (formKey.currentState!.validate()) {
                              await context.read<AuthCubit>().resetPassword(
                                  passwordController.text.trim());
                            }
                          },
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
