import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';

class ECommLogo extends StatelessWidget {
  const ECommLogo({super.key, this.style, required this.context, this.style2});
  final TextStyle? style;
  final TextStyle? style2;
  final BuildContext context;
  @override
  Widget build(context) {
    return Text.rich(
      TextSpan(
        text: 'E-',
        style:
            style ??
            context.theme.textTheme.headlineLarge?.copyWith(
              color:     context.adaptiveColor(
        lightColor: Colours.darkSurface,
        darkColor: Colours.lightSurface,
      ),
            ),
        children: [
          TextSpan(
            text: 'Comm',
            style:
                style2 ??
                context.theme.textTheme.headlineMedium?.copyWith(
                  color: context.adaptiveColor(
                    lightColor: Colours.darkButtonPrimary,
                    darkColor: Colours.darkButtonSecondary,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
