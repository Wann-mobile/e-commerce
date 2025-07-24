import 'package:e_triad/core/common/widgets/app_bar_bottom.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/src/auth/presntation_view/widgets/forgot_password_form.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  static const path = '/forgot-password';
  @override
  Widget build(BuildContext context) {
    final textT = context.theme.textTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        bottom: const AppBarBottom(),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 36),
        children: [
          Text('Confirm Email', style: textT.headlineLarge),
          Text(
            'Enter the email address associated with your account',
            style: textT.bodyMedium!.copyWith(color: Colors.grey),
          ),
        const Gap(40),
        const ForgotPasswordForm()
        ],
      ),
    );
  }
}
