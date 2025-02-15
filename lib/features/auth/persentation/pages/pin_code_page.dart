// features/auth/persentation/pages/pin_code_page.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/style_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

import '../../../../core/routes/routes.dart';

class PinCodePage extends StatefulWidget {
  const PinCodePage({super.key});

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
  static const String validPin = '1234';
  final TextEditingController _pinController = TextEditingController();
  String? _errorText;

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _validatePin(String value) {
    setState(() {
      _errorText = value == validPin ? null : 'Invalid code';
    });
    if (_errorText == null) {
      Navigator.pushReplacementNamed(context, Routes.resetPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Password', canPop: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            Text(
              'Email verification',
              style: getMediumStyle(
                color: ColorManager.black,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Please enter the code sent to your email address',
              textAlign: TextAlign.center,
              style: getRegularStyle(
                color: ColorManager.grey,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 32.h),
            Pinput(
              controller: _pinController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              defaultPinTheme: PinTheme(
                width: 74.w,
                height: 68.h,
                textStyle: getSemiBoldStyle(
                  color: ColorManager.black,
                  fontSize: 22.sp,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.pincode,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              errorPinTheme: PinTheme(
                width: 74.w,
                height: 68.h,
                textStyle: getSemiBoldStyle(
                  color: ColorManager.black,
                  fontSize: 22.sp,
                ),
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: ColorManager.error,
                  ),
                ),
              ),
              onChanged: (value) {
                if (_errorText != null) {
                  setState(() {
                    _errorText = null;
                  });
                }
              },
              onCompleted: _validatePin,
            ),
            if (_errorText != null)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, color: ColorManager.error, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      _errorText!,
                      style: getRegularStyle(
                        color: ColorManager.error,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
              ),
            SizedBox(height: 24.h),
            TextButton(
              onPressed: () {
                // Handle resend logic here
              },
              child: Text(
                "Didn't receive code? Resend",
                style: getTextUnderLine(color: ColorManager.blue, fontSize: 16.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
