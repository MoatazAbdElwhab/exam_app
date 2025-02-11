import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/gestures.dart';
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
  String validPin = '1234';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Password', canPop: true),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 40.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Email verification',
                style: getMediumStyle(
                  color: ColorManager.black,
                  fontSize: 18.sp,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Please enter your code that send to your',
                style: getRegularStyle(
                  color: ColorManager.grey,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                'email address',
                style: getRegularStyle(
                  color: ColorManager.grey,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                child: Column(
                  children: [
                    Pinput(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
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
                      validator: (value) {
                        return value == validPin ? null : 'Invalid code';
                      },
                      errorBuilder: (errorText, pin) {
                        return Padding(
                          padding: EdgeInsets.only(top: 8.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.error_outline,
                                color: ColorManager.error,
                                size: 16.sp,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                errorText!,
                                style: getRegularStyle(
                                  color: ColorManager.error,
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      onCompleted: (value) {
                        if (value == validPin) {
                          Navigator.pushReplacementNamed(
                              context, Routes.resetPassword);
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          RichText(
            text: TextSpan(
              style:
                  getRegularStyle(color: ColorManager.black, fontSize: 16.sp),
              children: [
                const TextSpan(text: "Didn't receive code? "),
                TextSpan(
                  text: 'Resend',
                  style: getTextUnderLine(
                      color: ColorManager.blue, fontSize: 16.sp),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
