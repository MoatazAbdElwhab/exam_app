// features/auth/persentation/pages/reset_password_page.dart
import 'package:exam_app/core/widgets/custom_text_form_field.dart';
import 'package:exam_app/features/auth/persentation/cubit/auth_cubit.dart';
import 'package:exam_app/features/auth/persentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:exam_app/core/widgets/custom_elevated_button.dart';
import '../../../../core/routes/routes.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;
  final String resetCode;

  const ResetPasswordPage(
      {super.key, required this.email, required this.resetCode});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isLoading = false;

  String? email;
  String? resetCode;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Only retrieve arguments once the widget has been fully initialized
    if (email == null || resetCode == null) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      email = args?['email'];
      resetCode = args?['resetCode'];

      if (email == null || resetCode == null) {
        _showErrorDialog('Missing email or reset code.');
      }
    }
  }

  void _resetPassword() {
    if (passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      _showErrorDialog('Please fill in all fields.');
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _showErrorDialog('Passwords do not match.');
      return;
    }

    if (email == null || resetCode == null) {
      _showErrorDialog('Missing email or reset code.');
      return;
    }

    context.read<AuthCubit>().resetPassword(
          email!,
          resetCode!,
          passwordController.text,
        );
  }

  @override
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status.isLoading) {
          // Delay the setState to avoid the issue during build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() => isLoading = true);
          });
        } else {
          // Delay the setState to avoid the issue during build
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() => isLoading = false);
          });
        }

        if (state.status.isSuccess) {
          // Navigate to login after successful password reset
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.login, (route) => false);
        } else if (state.status.isFailure) {
          _showErrorDialog(state.errorMessage ?? 'Failed to reset password.');
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Reset Password')),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CustomTextFormField(
                controller: passwordController,
                hint: 'New Password',
                label: 'New Password',
                isPass: true,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: confirmPasswordController,
                hint: 'Confirm Password',
                label: 'Confirm Password',
                isPass: true,
              ),
              const SizedBox(height: 24),
              CustomElevatedButton(
                title: isLoading ? 'Resetting...' : 'Reset Password',
                onTap: () => isLoading ? null : _resetPassword(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
