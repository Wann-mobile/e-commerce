import 'package:e_triad/core/common/widgets/app_bar_bottom.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/src/auth/presntation_view/views/login_screen.dart';
import 'package:e_triad/src/auth/presntation_view/widgets/registration_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  static const path = '/register';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up'), bottom: AppBarBottom()),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              children: [
                Text(
                  'Create an Account',
                  style: context.theme.textTheme.headlineLarge,
                ),
                Text(
                  'Create a new Ecomm account',
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const Gap(40),
                RegisterForm(),
              ],
            ),
          ),
          const Gap(8),
          RichText(
            text: TextSpan(
              text: 'Already have an account?',
              style: context.theme.textTheme.labelLarge?.copyWith(
                color: Colors.grey,
              ),
              children: [
                TextSpan(
                  text: ' Sign In',
                  style: TextStyle(
                    color: Colours.classicAdaptiveButtonOrIconColor(context),
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () => context.go(LoginScreen.path),
                ),
              ],
            ),
          ),
          const Gap(16),
        ],
      ),
    );
  }
}
