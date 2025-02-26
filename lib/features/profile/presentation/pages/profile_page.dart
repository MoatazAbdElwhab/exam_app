import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/image_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/data/data_models/user_dto.dart';
import 'package:exam_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:exam_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/di/injectable.dart';
import '../../../../core/logger/app_logger.dart';
import '../../../../core/widgets/dialog_utils.dart';

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
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late CustomElevatedButton customElevatedButton;
  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _phoneController = TextEditingController();
    Log.i('initState in profile');
  }

  @override
  void dispose() {
    Log.i('dispose in profile');
    _fullNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeDependencies() async {
    Log.i('didChangeDependencies profile');
    super.didChangeDependencies();
    authCubit = context.read<AuthCubit>();
    customElevatedButton = CustomElevatedButton(
      title: 'Update',
      shouldUseValidation: true,
      onTap: () {
        authCubit.editProfile(
            changedFields: UserDto(
          username: _fullNameController.text.trim(),
          firstName: _firstNameController.text.trim(),
          lastName: _lastNameController.text.trim(),
          email: _emailController.text.trim(),
          phone: _phoneController.text.trim(),
        ).toEditProfileMap());
      },
    );
    await authCubit.getLoggedUserInfo().then(
      (_) {
        final user = authCubit.state.user;
        if (user != null) {
          _fullNameController.text = user.username ?? '';
          _firstNameController.text = user.firstName ?? '';
          _lastNameController.text = user.lastName ?? '';
          _emailController.text = user.email ?? '';
          _passwordController.text = '*********';
          _phoneController.text = user.phone ?? '';
        }
      },
    );
    Log.i('end of didChangeDependencies profile');
  }

  @override
  Widget build(BuildContext context) {
    Log.i('build in profile');
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Profile',
          canPop: false,
        ),
        body: BlocListener<AuthCubit, AuthState>(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: formKey,
                  onChanged: () {
                    customElevatedButton.isFormValid(_checkValidation());
                  },
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
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                        ),
                        child: ElevatedButton(
                            onPressed: context.read<AuthCubit>().logout,
                            child: const Text('logout')),
                      ),
                      CustomTextFormField(
                        label: 'User name',
                        controller: _fullNameController,
                      ),

                      Gap(24.h),
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

                      Gap(24.h),
                      CustomTextFormField(
                        label: 'E-mail',
                        controller: _emailController,
                      ),

                      //password
                      Gap(24.h),
                      CustomTextFormField(
                        label: 'Password',
                        readOnly: true,
                        controller: _passwordController,
                        isPass: true,
                        suffixIcon: TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Routes.profileResetPassword);
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
                      customElevatedButton,
                    ],
                  ),
                ),
              ),
            ),
          ),
          listener: (context, state) {
            if (state.user != null || state.status.isProfileUpdated) {
              Log.i('listener got user != null');
              _fullNameController.text = state.user!.username ?? '';
              _firstNameController.text = state.user!.firstName ?? '';
              _lastNameController.text = state.user!.lastName ?? '';
              _emailController.text = state.user!.email ?? '';
              _passwordController.text = '*********';
              _phoneController.text = state.user!.phone ?? '';
            }
            if (state.errorMessage != null) {
              getIt<DialogUtils>().showSnackBar(
                  textColor: Colors.red,
                  message: state.errorMessage!,
                  context: context);
            }
            if (state.successMessage != null) {
              getIt<DialogUtils>().showSnackBar(
                  textColor: Colors.green,
                  message: state.successMessage!,
                  context: context);
            }
            if (state.status.isLoggedOut) {
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.login, (route) => false);
            }
          },
        ),
      ),
    );
  }

  bool _checkValidation() {
    final user = authCubit.state.user;
    if (user == null) return false;
    return _fullNameController.text.trim() != user.username ||
        _firstNameController.text.trim() != user.firstName ||
        _lastNameController.text.trim() != user.lastName ||
        _emailController.text.trim() != user.email ||
        _phoneController.text.trim() != user.phone;
  }
}
