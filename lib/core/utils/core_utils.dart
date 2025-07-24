import 'package:e_triad/core/extension/context_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

abstract class CoreUtils {
  const CoreUtils();

  static void showSnackBar(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
  }) {
    final snackBar = SnackBar(
      backgroundColor: backgroundColor ?? context.theme.primaryColor,
      content: Text(
        message,
        style: context.theme.textTheme.bodyMedium?.copyWith(
          color: Colors.white,
        ),
      ),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void postFrameCall(VoidCallback callback) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }
  

 
}
