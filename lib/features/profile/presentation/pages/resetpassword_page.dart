// features/profile/presentation/pages/resetpassword_page.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ResetpasswordPage extends StatelessWidget {
  const ResetpasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Reset Password',
          style: getMediumStyle(fontSize: 20.sp, color: ColorManager.black),
        ),
      ),

      //body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            //email
            CustomTextFormField(
              label: 'Current Password',
              hint: 'Current Password',
            ),
            Gap(24.h),

            //New password
            CustomTextFormField(
              label: 'New Password',
              hint: 'New Password',
            ),
            Gap(24.h),

            //Confirm  password
            CustomTextFormField(
              label: 'Confirm Password',
              hint: 'Confirm Password',
            ),

            Gap(54.h),
            //update button
            CustomElevatedButton(
              title: 'Login',
              onTap: () {},
              backgroundColor: ColorManager.grey,
            ),
          ],
        ),
      ),
    );
  }
}
