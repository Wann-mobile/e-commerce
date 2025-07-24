import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.height,
    this.padding,
    this.textStyle,
    this.backgroundColor, this.width,
  });

  final VoidCallback? onPressed;
  final String text;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 66,
      width: width ?? double.maxFinite,
      child: FilledButton(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),

          backgroundColor:
              backgroundColor ??
              Colours.classicAdaptiveButtonOrIconColor(context),
        ),
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          onPressed?.call();
        },
        child: Text(
          text,
          style:
              textStyle ??
              context.theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
              ),
        ),
      ),
    );
  }
}
