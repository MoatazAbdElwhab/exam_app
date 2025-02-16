// features/auth/persentation/pages/forgetpassword_page.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/style_manager.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/persentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/routes/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/auth_cubit.dart';

class ForgetpasswordPage extends StatefulWidget {
  const ForgetpasswordPage({super.key});

  @override
  State<ForgetpasswordPage> createState() => _ForgetpasswordPageState();
}

class _ForgetpasswordPageState extends State<ForgetpasswordPage> {
  //form key
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //email controller
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Reset Password', canPop: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text(
                  "Forget password",
                  style: getBoldStyle(
                    fontSize: 18.sp,
                    color: ColorManager.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(16.h),
                Text(
                  "Please enter your email associated to your account",
                  style: getLightStyle(
                    fontSize: 14.sp,
                    color: ColorManager.black,
                  ),
                ),
                Gap(32.h),
                CustomTextFormField(
                  label: 'Email',
                  hint: 'Enter your email',
                  controller: emailController,
                  validator: Validator.emailValidate,
                ),
                Gap(48.h),
                CustomElevatedButton(
                  title: 'Continue',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      // Call the Cubit to trigger the forgot password logic
                      context.read<AuthCubit>().forgotPassword(emailController.text);
                    }
                  },
                ),
                BlocListener<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state.status == AuthStatus.success) {
                      if (state.forgetPasswordMessage != null) {
                        // Show a dialog on success
                        _showDialog(context, 'Success', state.forgetPasswordMessage!);
                        // Navigate to the pin code page with the email
                        Navigator.pushNamed(
                          context,
                          Routes.pinCode,
                          arguments: emailController.text, // Pass email to PinCodePage
                        );
                      }
                    } else if (state.status == AuthStatus.failure) {
                      // Show an error dialog when the password reset fails
                      _showDialog(context, 'Error', state.errorMessage ?? 'An error occurred');
                    }
                  },
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Method to show the dialog
  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
