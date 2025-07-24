import 'dart:async';

import 'package:e_triad/core/common/app/cache_helper.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/core/services/injection_container_import.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_adapter_bloc.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_event.dart';
import 'package:e_triad/src/auth/presntation_view/app_adapter_bloc.dart/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpTimer extends StatefulWidget {
  const OtpTimer({super.key, required this.email});

  final String email;

  @override
  State<OtpTimer> createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  int _mainDuration = 60;
  int _duration = 60;
  int increment = 10;
  Timer? _timer;
  bool canResend = false;
  bool resending = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  void _startTimer() {
    sl<CacheHelper>().cacheTimer(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        sl<CacheHelper>().getCachedStartTimer();
        _duration--;
      });
      if (_duration == 0) {
        if (_mainDuration > 60) increment *= 2;

        _mainDuration += increment;
        _duration = _mainDuration;

        sl<CacheHelper>().getCachedEndTimerIn(_duration);
        timer.cancel();

        setState(() {
          canResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final minutes = _duration ~/ 60;
    final seconds = _duration.remainder(60);
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateOTPsent) {
          _startTimer();
          setState(() {
            canResend = false;
          });
        }
      },
      builder: (context, state) {
        return Center(
          child: switch (canResend) {
            true => switch (state) {
              AuthStateLoading _ => SizedBox.shrink(),
              _ => TextButton(
                onPressed: () async {
                  context.read<AuthBloc>().add(
                    EventForgotPasswordRequested(email: widget.email),
                  );
                },
                child: Text(
                  'Resend Code',
                  style: context.theme.textTheme.bodySmall?.copyWith(
                    color: Colours.classicAdaptiveButtonOrIconColor(context),
                  ),
                ),
              ),
            },
            _ => RichText(
              text: TextSpan(
                text: 'Resend code in ',
                style: context.theme.textTheme.bodySmall?.copyWith(
                  color: Colors.grey,
                ),
                children: [
                  TextSpan(
                    text: '$minutes:${seconds.toString().padLeft(2, '0')}',
                    style: context.theme.textTheme.bodySmall?.copyWith(
                      color: Colours.classicAdaptiveButtonOrIconColor(context),
                    ),
                  ),
                  const TextSpan(text: ' seconds'),
                ],
              ),
            ),
          },
        );
      },
    );
  }
}
