import 'package:e_triad/core/common/widgets/rounded_button.dart';
import 'package:e_triad/core/extension/widget_ext.dart';
import 'package:e_triad/core/utils/core_utils.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_adapter_bloc.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_event.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_state.dart';
import 'package:e_triad/src/auth/presntation_view/views/verify_otp_screen.dart';
import 'package:e_triad/src/auth/presntation_view/widgets/vertical_label_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state case AuthStateError(:final message)) {
          CoreUtils.showSnackBar(context, message: message);
        } else if (state is AuthStateOTPsent) {
          context.pushReplacement(
            VerifyOtpScreen.path,
            extra: emailController.text.trim(),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              VerticalLabelField(
                controller: emailController,
                label: 'Email',
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
              ),
              const Gap(40),
              RoundedButton(
                text: 'Continue',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final email = emailController.text.trim();
                    context.read<AuthBloc>().add(
                      EventForgotPasswordRequested(email: email),
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
