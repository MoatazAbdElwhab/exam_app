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
    authCubit = context.read<AuthCubit>(); // Moved from didChangeDependencies
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

  void _updateControllers(AuthState state) {
    if (state.user != null) {
      if (_fullNameController.text != state.user!.username) {
        _fullNameController.text = state.user!.username!;
      }
      if (_firstNameController.text != state.user!.firstName) {
        _firstNameController.text = state.user!.firstName!;
      }
      if (_lastNameController.text != state.user!.lastName) {
        _lastNameController.text = state.user!.lastName!;
      }
      if (_emailController.text != state.user!.email) {
        _emailController.text = state.user!.email!;
      }
      if (_phoneController.text != state.user!.phone) {
        _phoneController.text = state.user!.phone!;
      }
      _passwordController.text = '*********'; // Keep password masked
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Profile', canPop: false),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) => _updateControllers(state),
          builder: (context, state) {
            if (state.user == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
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
                          radius: 60,
                          backgroundImage: AssetImage(ImageManager.userPng),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {}, // Implement image picker
                        child: CircleAvatar(
                          radius: 15,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                          child: const Icon(Icons.camera_alt_rounded, size: 20),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormField(label: 'User name', controller: _fullNameController),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      Expanded(child: CustomTextFormField(label: 'First name', controller: _firstNameController)),
                      SizedBox(width: 16.w),
                      Expanded(child: CustomTextFormField(label: 'Last name', controller: _lastNameController)),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormField(label: 'E-mail', controller: _emailController),
                  SizedBox(height: 24.h),
                  CustomTextFormField(
                    label: 'Password',
                    controller: _passwordController,
                    isPass: true,
                    suffixIcon: TextButton(
                      onPressed: () => Navigator.pushNamed(context, Routes.resetPassword),
                      child: Text('change', style: getRegularStyle(color: ColorManager.blue, fontSize: 14.sp)),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormField(label: 'Phone number', controller: _phoneController),
                  SizedBox(height: 48.h),
                  CustomElevatedButton(title: 'Update', onTap: () {}),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
