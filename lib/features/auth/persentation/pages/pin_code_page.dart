// features/auth/persentation/pages/pin_code_page.dart
import 'package:exam_app/features/auth/persentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/style_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/routes/routes.dart';
import '../cubit/auth_cubit.dart';

class PinCodePage extends StatefulWidget {
  final String email; // Email is passed through the constructor

  const PinCodePage({super.key, required this.email});

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  AuthCubit? cubit;
  final TextEditingController pinController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    cubit ??= context.read<AuthCubit>(); // Get the AuthCubit instance
    // No need to use ModalRoute for fetching email, it's already passed in constructor
    if (widget.email.isEmpty) {
      _showErrorDialog(context, 'Email is missing');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status.isLoading) {
          setState(() => isLoading = true);
        } else {
          setState(() => isLoading = false);
        }

        if (state.status.isSuccess) {
          // After success, navigate to the next page
          Navigator.pushNamed(
            context,
            Routes.resetPassword, // Ensure this route is correct
            arguments: {
              'email': widget.email,
              'resetCode': state.resetCode

            }, // Use the email from widget
          );
        } else if (state.status.isFailure) {
          _showErrorDialog(context, state.errorMessage ?? 'Invalid PIN');
        }
      },
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Password', canPop: true),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h),
              Text(
                'Email verification',
                style:
                    getMediumStyle(color: ColorManager.black, fontSize: 18.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                'Please enter the code sent to your email address',
                textAlign: TextAlign.center,
                style:
                    getRegularStyle(color: ColorManager.grey, fontSize: 14.sp),
              ),
              SizedBox(height: 32.h),
              Pinput(
                length: 6,
                controller: pinController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                defaultPinTheme: PinTheme(
                  width: 74.w,
                  height: 68.h,
                  textStyle: getSemiBoldStyle(
                      color: ColorManager.black, fontSize: 22.sp),
                  decoration: BoxDecoration(
                    color: ColorManager.pincode,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                errorPinTheme: PinTheme(
                  width: 74.w,
                  height: 68.h,
                  textStyle: getSemiBoldStyle(
                      color: ColorManager.black, fontSize: 22.sp),
                  decoration: BoxDecoration(
                    color: ColorManager.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: ColorManager.error),
                  ),
                ),
                onCompleted: (pin) {
                  if (pin.isNotEmpty && widget.email.isNotEmpty) {
                    cubit?.verifyResetCode(
                        pin, widget.email); // Use email from widget
                  } else {
                    _showErrorDialog(context, 'Invalid PIN or missing email');
                  }
                },
              ),
              SizedBox(height: 24.h),
              CustomElevatedButton(
                title: isLoading ? 'Verifying...' : 'Verify PIN',
                onTap: () {
                  if (pinController.text.isNotEmpty &&
                      widget.email.isNotEmpty &&
                      !isLoading) {
                    cubit?.verifyResetCode(pinController.text,
                        widget.email); // Use email from widget
                  } else {
                    _showErrorDialog(context, 'Invalid PIN or missing email');
                  }
                },
              ),
              SizedBox(height: 24.h),
              TextButton(
                onPressed: () {
                  // Handle resend logic here
                },
                child: Text(
                  "Didn't receive code? Resend",
                  style: getTextUnderLine(
                      color: ColorManager.blue, fontSize: 16.sp),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
