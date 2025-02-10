import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ResetpasswordPage extends StatefulWidget {
  const ResetpasswordPage({super.key});

  @override
  State<ResetpasswordPage> createState() => _ResetpasswordPageState();
}

class _ResetpasswordPageState extends State<ResetpasswordPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Reset Password',canPop: true,),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:16.w,vertical: 16.h),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              //email
              CustomTextFormField(
                label: 'Current Password',
                hint: 'Current Password',
                validator: (p0) => Validator.passwordValidation(p0),
              ),
              Gap(24.h),

              //New password
              CustomTextFormField(
                label: 'New Password',
                hint: 'New Password',
                controller: passwordController,
                validator: (p0) => Validator.passwordValidation(p0),
              ),
              Gap(24.h),

              //Confirm  password
              CustomTextFormField(
                label: 'Confirm Password',
                hint: 'Confirm Password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'please enter your confirm password';
                  } else if (value != passwordController.text) {
                    return 'password not match';
                  } else {
                    return null;
                  }
                },
              ),

              Gap(54.h),
              //update button
              CustomElevatedButton(
                title: 'Update',
                onTap: () {
                  if (formKey.currentState!.validate()) {}
                },
                backgroundColor: ColorManager.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
