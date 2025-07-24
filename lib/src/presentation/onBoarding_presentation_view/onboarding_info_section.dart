import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:e_triad/core/res/media.dart';
import 'package:flutter/material.dart';

class OnboardingInfoSection extends StatelessWidget {
  const OnboardingInfoSection.first({super.key}) : first = true;
  const OnboardingInfoSection.second({super.key}) : first = false;

  final bool first;

  @override
  Widget build(BuildContext context) {
    final textTheme = context.theme.textTheme;
    return Stack(
      clipBehavior: Clip.none,
      alignment: AlignmentDirectional.center,
      children: [
        Image.asset(
          first ? Media.onBoardingMale : Media.onBoardingFemale,
          scale: 7,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            switch (first) {
              true => Text.rich(
                textAlign: TextAlign.left,
                TextSpan(
                  text: '${DateTime.now().year}\n',
                  style: textTheme.displaySmall,
                  children: [
                    TextSpan(
                      text: 'Shopping Redefined',
                      style: TextStyle(
                        color: Colours.classicAdaptiveTextColor(context),
                      ),
                    ),
                  ],
                ),
              ),
              _ => Text.rich(
                textAlign: TextAlign.left,
                TextSpan(
                  text: 'Shop easily and\n',
                  style: textTheme.displaySmall,
                  children: [
                    TextSpan(
                      text: 'Shop smartly dear user ',
                      style: TextStyle(
                        color: Colours.classicAdaptiveTextColor(context),
                      ),
                    ),
                  ],
                ),
              ),
            },
          ],
        ),
      ],
    );
  }
}
