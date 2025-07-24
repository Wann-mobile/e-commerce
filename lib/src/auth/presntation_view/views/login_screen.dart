import 'package:e_triad/core/common/widgets/app_bar_bottom.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/src/auth/presntation_view/views/registration_screen.dart';
import 'package:e_triad/src/auth/presntation_view/widgets/login_form.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static const path = '/login';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In'), bottom: AppBarBottom()),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 16),
              children: [
                Text('Hello!!', style: context.theme.textTheme.headlineLarge),
                Text(
                  'Sign in with your account details',
                  style: context.theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const Gap(40),
                LoginForm(),
              ],
            ),
          ),
          const Gap(8),
          RichText(
            text: TextSpan(
              text: 'Don\'t have an account?',
              style: context.theme.textTheme.labelLarge?.copyWith(
                color: Colors.grey,
              ),
              children: [
                TextSpan(
                  text: ' Create Account',
                  style: TextStyle(
                    color: Colours.classicAdaptiveButtonOrIconColor(context),
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          context.go(RegistrationScreen.path);
                        },
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
