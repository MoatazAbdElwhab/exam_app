import 'package:exam_app/core/resources/color_manager.dart';
import 'package:exam_app/core/resources/styles_manager.dart';
import 'package:exam_app/core/utils/validator.dart';
import 'package:exam_app/core/widgets/custom_app_bar.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/core/widgets/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import '../../../../core/di/injectable.dart';
import '../../../../core/routes/routes.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

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
  CustomElevatedButton? customElevatedButton;

  late final AuthCubit cubit;

  @override
  void didChangeDependencies() {
    cubit = context.read<AuthCubit>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Password',
        canPop: true,
      ),
      //body
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Center(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (BuildContext context, AuthState state) {
              final dialogUtils = getIt<DialogUtils>();
               if (state.errorMessage != null) {
                dialogUtils.showSnackBar(
                    textColor: Colors.red,
                    message: state.errorMessage!,
                    context: context);
              } else if (state.successMessage != null) {
                dialogUtils.showSnackBar(
                    textColor: Colors.green,
                    message: state.successMessage!,
                    context: context);
              } else if (state.shouldSendOtp == true) {
                if (context.mounted) {
                    Navigator.pushNamed(context, Routes.pinCode);
                }
              }
            },
            builder: (context, state) => state.status.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Form(
                    onChanged: () {
                      if (customElevatedButton != null) {
                        customElevatedButton!.isFormValid(
                            Validator.emailValidate(
                                    emailController.text.trim()) ==
                                null);
                      }
                    },
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
                        validator: Validator.emailValidate,
                      ),
                      Gap(48.h),
                      customElevatedButton = CustomElevatedButton(
                        title: 'Continue',
                        onTap: () async {
                          if (formKey.currentState!.validate()) {
                            await cubit.forgotPassword(emailController.text);
                          }
                        },
                      ),
                    ]),
                  ),
          ),
        ),
      ),
    );
  }
}
