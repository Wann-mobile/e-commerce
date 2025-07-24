import 'package:e_triad/core/common/widgets/app_bar_bottom.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/src/auth/presntation_view/widgets/reset_password_form.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  static const path = '/reset-password';
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        bottom: const AppBarBottom(),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        children: [
          Text('Change Password', style: context.theme.textTheme.headlineLarge),
          Text(
            'Pick a new secure password',
            style: context.theme.textTheme.bodyMedium!.copyWith(
              color: Colors.grey,
            ),
          ),
          const Gap(20),
          ResetPasswordForm(email: email,),
        ],
      ),
    );
  }
}
