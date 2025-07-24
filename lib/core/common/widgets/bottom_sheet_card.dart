import 'package:e_triad/core/common/widgets/rounded_button.dart';
import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BottomSheetCard extends StatelessWidget {
  const BottomSheetCard({
    super.key,
    required this.title,
    required this.positiveButtonText,
    required this.negativeButtonText,
    required this.positiveButtonColor,
  });

  final String title;
  final String positiveButtonText;
  final String negativeButtonText;
  final Color positiveButtonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: context.theme.scaffoldBackgroundColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: context.theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Gap(40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 4,
                  child: RoundedButton(
                    text: positiveButtonText,
                    textStyle: context.theme.textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                    ),
                    backgroundColor: positiveButtonColor,
                    height: 55,
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ),
                const Spacer(),
                Expanded(
                  flex: 5,
                  child: RoundedButton(
                    text: negativeButtonText,
                    textStyle: context.theme.textTheme.titleLarge!.copyWith(
                      color: Colours.classicAdaptiveButtonOrIconColor(context),
                    ),
                    backgroundColor: Colors.transparent,
                    height: 55,
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
