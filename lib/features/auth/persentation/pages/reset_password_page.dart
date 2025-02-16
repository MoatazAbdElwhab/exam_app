// features/auth/persentation/pages/reset_password_page.dart
import 'package:exam_app/core/utils/validator.dart';
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
  // form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  // New password and confirm password variables
  String password = '';
  String confirmPassword = '';

  void _resetPassword() {
    if (_formKey.currentState?.validate() ?? false) {
      // If form is valid, proceed with the password reset
      context
          .read<AuthCubit>()
          .resetPassword(widget.email, widget.resetCode, password);
    } else {
      _showErrorDialog('Please fill in all fields correctly.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.status.isLoading) {
          setState(() => isLoading = true);
        } else {
          setState(() => isLoading = false);
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // New Password input field

                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    hintText: 'Enter new password',
                  ),
                  obscureText: true,
                  onChanged: (value) => password = value,
                  validator: Validator.passwordValidation,
                ),
                const SizedBox(height: 16),
                // Confirm Password input field
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm your password',
                  ),
                  obscureText: true,
                  onChanged: (value) => confirmPassword = value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != password) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
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
