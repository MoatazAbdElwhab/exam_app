import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:exam_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/routes/routes.dart';

class PinCodePage extends StatefulWidget {
  const PinCodePage({super.key});

  @override
  State<PinCodePage> createState() => _PinCodePageState();
}

class _PinCodePageState extends State<PinCodePage> {
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
              BlocListener<AuthCubit, AuthState>(
                listenWhen: (prev, cur) =>
                    cur.resetPasswordCode != null ||
                    cur.shouldUpdatePassword != null,
                listener: (context, state) {
                  if (state.shouldUpdatePassword == true) {
                    Navigator.of(context).pushNamed(Routes.resetPassword);
                  }
                },
                child: Form(
                  child: Column(
                    children: [
                      Pinput(
                        length: 6,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        defaultPinTheme: PinTheme(
                          width: 48.w,
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
                          width: 48.w,
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
                        onCompleted: (value) async {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                insetPadding: EdgeInsets.zero,
                                backgroundColor:
                                    Colors.purple.withValues(alpha: 0.03),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.purple.withValues(alpha: 0.6),
                                )),
                              );
                            },
                          );
                          await context
                              .read<AuthCubit>()
                              .verifyResetCode(value)
                              .then(
                            (value) {
                              if (ScaffoldMessenger.of(context).mounted) {
                                Navigator.of(context).pop();
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
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
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                insetPadding: EdgeInsets.zero,
                                backgroundColor:
                                    Colors.purple.withValues(alpha: 0.03),
                                child: Center(
                                    child: CircularProgressIndicator(
                                  color: Colors.purple.withValues(alpha: 0.6),
                                )),
                              );
                            });
                        await context
                            .read<AuthCubit>()
                            .resendForgetPassword()
                            .then((value) {
                          if (ScaffoldMessenger.of(context).mounted) {
                            Navigator.of(context).pop();
                          }
                        });
                      }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
