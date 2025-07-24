import 'package:e_triad/core/common/widgets/app_bar_bottom.dart';
import 'package:e_triad/core/common/widgets/rounded_button.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/extension/string_ext.dart';
import 'package:e_triad/core/extension/widget_ext.dart';
import 'package:e_triad/core/utils/core_utils.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_adapter_bloc.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_event.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_state.dart';
import 'package:e_triad/src/auth/presntation_view/views/reset_password_screen.dart';
import 'package:e_triad/src/auth/presntation_view/widgets/otp_fields.dart';
import 'package:e_triad/src/auth/presntation_view/widgets/otp_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});

  static const path = '/verify-otp';

  final String email;
  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final otpController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    otpController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state case AuthStateError(:final message)) {
          CoreUtils.showSnackBar(context, message: message);
        } else if (state is AuthStateOTPVerified) {
          CoreUtils.showSnackBar(context, message: 'OTP verified');
          context.push(ResetPasswordScreen.path, extra: widget.email);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Verify OTP'),
            bottom: const AppBarBottom(),
          ),
          body: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            children: [
              Text(
                'Verification Code',
                style: context.theme.textTheme.headlineLarge,
              ),
              Text(
                'Code has been sent to ${widget.email.obscureEmail}',
                style: context.theme.textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                ),
              ),
              const Gap(30),
              OtpFields(controller: otpController),
              const Gap(30),
              OtpTimer(email: widget.email),
              const Gap(40),
              RoundedButton(
                onPressed: () {
                  if (otpController.text.length < 4) {
                    CoreUtils.showSnackBar(context, message: 'Invalid OTP');
                  } else {
                    context.read<AuthBloc>().add(
                      EventVerifyOtpRequested(
                        otp: otpController.text.trim(),
                        email: widget.email,
                      ),
                    );
                  }
                },
                text: 'Verify',
              ).loading(isLoading: state is AuthStateLoading),
            ],
          ),
        );
      },
    );
  }
}
