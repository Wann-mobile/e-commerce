import 'package:e_triad/core/common/widgets/rounded_button.dart';
import 'package:e_triad/core/extension/widget_ext.dart';
import 'package:e_triad/core/utils/core_utils.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_adapter_bloc.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_event.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_state.dart';
import 'package:e_triad/src/auth/presntation_view/widgets/vertical_label_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key, required this.email});
  final String email;

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final formKey = GlobalKey<FormState>();
  final confirmPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePasswordNotifier = ValueNotifier(true);
  final obscureConfirmPasswordNotifier = ValueNotifier(true);

  @override
  void dispose() {
    super.dispose();
    confirmPasswordController.dispose();
    passwordController.dispose();
    obscurePasswordNotifier.dispose();
    obscureConfirmPasswordNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state case AuthStateError(:final message)) {
          CoreUtils.showSnackBar(context, message: message);
        } else if (state is AuthStatePasswordReset) {
          CoreUtils.showSnackBar(
            context,
            message: 'Password reset successfully',
          );
          context.go('/');
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: obscurePasswordNotifier,
                builder: (_, obsecureText, __) {
                  return VerticalLabelField(
                    controller: passwordController,
                    label: 'Password',
                    hintText: 'Enter your password',
                    obsecureText: obsecureText,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        obscurePasswordNotifier.value =
                            !obscurePasswordNotifier.value;
                      },
                      child: Icon(switch (obsecureText) {
                        true => Icons.visibility_off_outlined,
                        _ => Icons.visibility_outlined,
                      }),
                    ),
                  );
                },
              ),
              const Gap(20),
              ValueListenableBuilder(
                valueListenable: obscureConfirmPasswordNotifier,
                builder: (_, obsecureConfirmText, __) {
                  return VerticalLabelField(
                    controller: confirmPasswordController,
                    label: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    obsecureText: obsecureConfirmText,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: GestureDetector(
                      onTap: () {
                        obscureConfirmPasswordNotifier.value =
                            !obscureConfirmPasswordNotifier.value;
                      },
                      child: Icon(switch (obsecureConfirmText) {
                        true => Icons.visibility_off_outlined,
                        _ => Icons.visibility_outlined,
                      }),
                    ),
                    validator: (value) {
                      if (value! != passwordController.text.trim()) {
                        return 'Password does not match';
                      } else {
                        return null;
                      }
                    },
                  );
                },
              ),
              const Gap(40),
              RoundedButton(
                text: 'Submit',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    final newPassword = confirmPasswordController.text.trim();
                    context.read<AuthBloc>().add(
                      EventResetPasswordRequested(
                        newPassword: newPassword,
                        email: widget.email,
                      ),
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
