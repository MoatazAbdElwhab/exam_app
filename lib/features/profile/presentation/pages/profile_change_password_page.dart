import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:exam_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/di/injectable.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/dialog_utils.dart';

class ProfileChangePasswordPage extends StatefulWidget {
  const ProfileChangePasswordPage({super.key});

  @override
  State<ProfileChangePasswordPage> createState() =>
      _ProfileChangePasswordPageState();
}

class _ProfileChangePasswordPageState extends State<ProfileChangePasswordPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late final TextEditingController oldPasswordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmNewPasswordController;
  late CustomElevatedButton customElevatedButton;
  late final AuthCubit cubit;

  @override
  void initState() {
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    cubit = context.read<AuthCubit>();
    customElevatedButton = CustomElevatedButton(
      title: 'Update',
      shouldUseValidation: true,
      onTap: () async {
        if (formKey.currentState!.validate()) {
          context.read<AuthCubit>().changePassword(
                oldPassword: oldPasswordController.text.trim(),
                newPassword: newPasswordController.text.trim(),
              );
        }
      },
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Reset Password',
        canPop: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: cubit.state.status.isLoading
            ? const Center(child: CircularProgressIndicator())
            : Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: () {
                  customElevatedButton.isFormValid(((_confirmPasswordValidation(
                            confirmNewPasswordController.text.trim(),
                          ) ==
                          null) &&
                      Validator.passwordValidation(
                              newPasswordController.text.trim()) ==
                          null &&
                      Validator.passwordValidation(
                              oldPasswordController.text.trim()) ==
                          null));
                },
                key: formKey,
                child: Column(
                  children: [
                    //email
                    CustomTextFormField(
                      label: 'Current Password',
                      hint: 'Current Password',
                      controller: oldPasswordController,
                      validator: Validator.passwordValidation,
                    ),
                    Gap(24.h),

                    //New password
                    CustomTextFormField(
                      label: 'New Password',
                      hint: 'New Password',
                      controller: newPasswordController,
                      validator: Validator.passwordValidation,
                    ),
                    Gap(24.h),

                    CustomTextFormField(
                      label: 'Confirm Password',
                      hint: 'Confirm Password',
                      controller: confirmNewPasswordController,
                      validator: _confirmPasswordValidation,
                    ),

                    Gap(54.h),
                    //update button
                    BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state.errorMessage != null) {
                            getIt<DialogUtils>().showSnackBar(
                                textColor: Colors.red,
                                message: state.errorMessage!,
                                context: context);
                          }
                          if (state.successMessage != null) {
                            showGeneralDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierLabel: 'Barrier',
                              barrierColor: Colors.black.withValues(alpha: 0.5),
                              transitionDuration:
                                  const Duration(milliseconds: 300),
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return AlertDialog(
                                  title: const Text('Success!'),
                                  content: Text(state.successMessage!),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).popUntil(
                                              (route) =>
                                                  route.settings.name ==
                                                  Routes.navbar);
                                        },
                                        child: const Text('Close')),
                                  ],
                                );
                              },
                              transitionBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation,
                                  Widget child) {
                                return FadeTransition(
                                  opacity: CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOut,
                                  ),
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, -0.5),
                                      end: Offset.zero,
                                    ).animate(CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeOut,
                                    )),
                                    child: child,
                                  ),
                                );
                              },
                            );
                          }
                        },
                        child: customElevatedButton),
                  ],
                ),
              ),
      ),
    );
  }

  String? _confirmPasswordValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'please enter your confirm password';
    } else if (value != newPasswordController.text) {
      return 'password not match';
    } else {
      return null;
    }
  }
}
