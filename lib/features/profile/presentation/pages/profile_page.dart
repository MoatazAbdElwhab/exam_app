import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/image_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/routes/routes.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
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

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
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
    Log.e('ProfilePage initState called');
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
    super.didChangeDependencies();
    // if (!_hasInitiallyLoaded) {
    authCubit = context.read<AuthCubit>(); // Move this inside the if check
    // Use addPostFrameCallback instead of microtask for better frame timing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Log.i(authCubit.state.user != null);
      if (mounted) {
        Log.i('profileGetInfo');
        authCubit.getLoggedUserInfo();
        //     .then((_) =>
        // _hasInitiallyLoaded = true
        // );
      }
    });
    // }
  }

  @override
  Widget build(BuildContext context) {
    Log.e('build called in profile');
    super.build(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: const CustomAppBar(
          title: 'Profile',
          canPop: false,
        ),
        //body
        body: BlocConsumer<AuthCubit, AuthState>(
          // buildWhen: (previous, current) => _hasInitiallyLoaded,
          // previous.status != current.status ||
          // previous.user != current.user ||
          // current.user != null || current.user != previous.user,
          // listenWhen: (previous, current) =>
          // previous.errorMessage != current.errorMessage ||
          //     current.user != null ||
          //     previous.successMessage != current.successMessage ||
          //     previous.status.isLoggedOut != current.status.isLoggedOut,
          builder: (context, state) {
            Log.e('bloc builder in profile');
            // if (state.status.isLoading) {
            //   return const Center(child: CircularProgressIndicator());
            // }
            return SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            // await getIt<LocalStorageClient>().saveRememberMe(false);
                            // await  context
                            //      .read<AuthCubit>()
                            //      .logout();
                            Navigator.of(context).pushNamed(Routes.result);
                            // await getIt<AuthCubit>().close();
                          },
                          child: Text('data')),
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
                            onPressed: () async {
                              await context.read<AuthCubit>().logout();
                              // Navigator.pushNamed(
                              //     context, Routes.changePassword);
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
            Log.e('listener build user != null ${state.user != null}');
            if (state.user != null) {
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

  @override
  bool get wantKeepAlive => true;
// @override
// bool get wantKeepAlive => true;
}
