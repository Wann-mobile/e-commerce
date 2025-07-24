import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';

class AnimatedDot extends StatelessWidget {
  const AnimatedDot({super.key, required this.isDotActive});

  final bool isDotActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: 6,
      width: isDotActive ? 20 : 6,
      decoration: BoxDecoration(
        color:
            isDotActive
                ? Colours.darkButtonPrimary
                : Colours.darkButtonPrimary.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
