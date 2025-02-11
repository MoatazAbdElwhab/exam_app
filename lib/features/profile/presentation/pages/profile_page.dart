import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/image_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Profile',
        canPop: false,
      ),

      //body
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                //image
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: ColorManager.white,
                      child: CircleAvatar(
                        backgroundColor: ColorManager.white,
                        radius: 60,
                        backgroundImage: AssetImage(ImageManager.userPng),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {},
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                        child: const Icon(
                          Icons.camera_alt_rounded,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),

                //user name
                Gap(24.h),
                CustomTextFormField(
                  label: 'User name',
                  hint: 'Enter your user name',
                ),

                Gap(24.h),
                //first name & last name
                Row(
                  children: [
                    const Expanded(
                      child: CustomTextFormField(
                        label: 'First name',
                        hint: 'Enter your first name',
                      ),
                    ),
                    SizedBox(width: 16.w),
                    const Expanded(
                      child: CustomTextFormField(
                        label: 'Last name',
                        hint: 'Enter your last name',
                      ),
                    ),
                  ],
                ),

                //email
                Gap(24.h),
                const CustomTextFormField(
                  label: 'E-mail',
                  hint: 'Enter your first E-mail',
                ),

                //password
                Gap(24.h),
                CustomTextFormField(
                  label: 'Password',
                  hint: 'Enter your password',
                  isPass: true,
                  suffixIcon: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.resetPassword);
                      },
                      child: Text(
                        'change',
                        style: getRegularStyle(
                            color: ColorManager.blue, fontSize: 14.sp),
                      )),
                ),

                //phone number
                Gap(24.h),
                const CustomTextFormField(
                  label: 'Phone number',
                  hint: 'Enter your phone number',
                ),

                //button update
                Gap(48.h),
                CustomElevatedButton(
                  title: 'Update',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
