import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';

class ViewAll extends StatelessWidget {
  const ViewAll({
    super.key,
    required this.title,
    required this.onViewAllPressed,
  });

  final String title;
  final VoidCallback onViewAllPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: context.theme.textTheme.headlineSmall!.copyWith(
            color: Colours.classicAdaptiveTextColor(context),
            fontWeight: FontWeight.w600,
            fontSize: 21,
          ),
        ),
        Spacer(),
        Column(
          children: [
            SizedBox(height: 10),
            TextButton(
              onPressed: onViewAllPressed,
              child: Text(
                'View All ->',
                style: context.theme.textTheme.labelLarge!.copyWith(
                  color: Colours.classicAdaptiveButtonOrIconColor(context),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
