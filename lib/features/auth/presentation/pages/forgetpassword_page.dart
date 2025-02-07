import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Password',
          style: getMediumStyle(fontSize: 20.sp, color: ColorManager.black),
        ),
      ),

      //body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: formKey,
            child: Column(children: [
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
              //email
              CustomTextFormField(
                label: 'Email',
                hint: 'Enter you email',
                controller: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your email';
                  } else if (!Validator.emailValidate(value)) {
                    return 'enter valid email';
                  } else {
                    return null;
                  }
                },
              ),
              Gap(48.h),
              CustomElevatedButton(
                title: 'Continue',
                onTap: () {
                  if (formKey.currentState!.validate()) {}
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
