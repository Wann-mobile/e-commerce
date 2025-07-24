import 'package:e_triad/core/common/app/cache_helper.dart';
import 'package:e_triad/core/common/widgets/rounded_button.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/core/services/injection_container_import.dart';
import 'package:e_triad/core/utils/core_utils.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_adapter_bloc.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_event.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_state.dart';
import 'package:e_triad/src/auth/presntation_view/views/forgot_password_screen.dart';
import 'package:e_triad/src/auth/presntation_view/widgets/vertical_label_field.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/extension/widget_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obsecurePaswordNotifier = ValueNotifier(true);

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    obsecurePaswordNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state case AuthStateError(:final message)) {
          CoreUtils.showSnackBar(context, message: message);
        } else if (state is AuthStateLoggedIn) {
          sl<CacheHelper>()
            ..getSessionToken()
            ..getUserId();
          context.go('/', extra: 'home');
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              VerticalLabelField(
                label: 'Email',
                controller: emailController,
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
              ),
              const Gap(20),
              ValueListenableBuilder(
                valueListenable: obsecurePaswordNotifier,
                builder: (_, obsecurePassword, _) {
                  return VerticalLabelField(
                    controller: passwordController,
                    label: 'Password',
                    hintText: 'Enter your password',
                    keyboardType: TextInputType.visiblePassword,
                    obsecureText: obsecurePassword,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        obsecurePaswordNotifier.value =
                            !obsecurePaswordNotifier.value;
                      },
                      child: Icon(
                        obsecurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: Colours.classicAdaptiveButtonOrIconColor(
                          context,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const Gap(20),
              SizedBox(
                width: double.maxFinite,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      context.push(ForgotPasswordScreen.path);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: context.theme.textTheme.bodySmall!.copyWith(
                        color: Colours.classicAdaptiveButtonOrIconColor(
                          context,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(40),
              RoundedButton(
                text: 'Sign In',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final email = emailController.text.trim();
                    final password = passwordController.text.trim();
                    context.read<AuthBloc>().add(
                      EventLoginRequested(email: email, password: password),
                    );
                  }
                },
              ).loading(isLoading: state is AuthStateLoading),
            ],
          ),
        );
      },
    );
  }
}
