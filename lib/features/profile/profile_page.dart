// features/profile/profile_page.dart
import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/image_manager.dart';
import 'package:exam_app/core/resources/style_manager.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/persentation/cubit/auth_cubit.dart';
import 'package:exam_app/features/auth/persentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final AuthCubit authCubit;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _fullNameController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    authCubit = context.read<AuthCubit>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Profile',
          canPop: false,
        ),

        //body
        body: BlocConsumer<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state.user == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
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
                        controller: _fullNameController,
                      ),

                      Gap(24.h),
                      //first name & last name
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              label: 'First name',
                              controller: _firstNameController,
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: CustomTextFormField(
                              label: 'Last name',
                              controller: _lastNameController,
                            ),
                          ),
                        ],
                      ),

                      //email
                      Gap(24.h),
                      CustomTextFormField(
                        label: 'E-mail',
                        controller: _emailController,
                      ),

                      //password
                      Gap(24.h),
                      CustomTextFormField(
                        label: 'Password',
                        controller: _passwordController,
                        isPass: true,
                        suffixIcon: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, Routes.resetPassword);
                            },
                            child: Text(
                              'change',
                              style: getRegularStyle(
                                  color: ColorManager.blue, fontSize: 14.sp),
                            )),
                      ),

                      //phone number
                      Gap(24.h),
                      CustomTextFormField(
                        label: 'Phone number',
                        controller: _phoneController,
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
            );
          },
          listener: (context, state) {
            _fullNameController.text = authCubit.state.user!.username!;
            _firstNameController.text = authCubit.state.user!.firstName!;
            _lastNameController.text = authCubit.state.user!.lastName!;
            _emailController.text = authCubit.state.user!.email!;
            _passwordController.text = '*********';
            _phoneController.text = authCubit.state.user!.phone!;
          },
        ),
      ),
    );
  }
}