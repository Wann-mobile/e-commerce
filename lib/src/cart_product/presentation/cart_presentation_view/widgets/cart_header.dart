import 'package:e_triad/core/extension/context_ext.dart';
import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';

class CartHeader extends StatelessWidget {
  const CartHeader({super.key, required this.title, required this.content, this.titleStyle, this.contentStyle});
  final String title;
  final TextStyle? titleStyle;
   final TextStyle? contentStyle;
  final String content;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.05,
      width: double.maxFinite,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colours.classicAdaptiveBgCardColor(context),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: titleStyle ?? context.theme.textTheme.bodyLarge!.copyWith(
              color: context.textColor,
              fontWeight: FontWeight.w800,
            ),
          ),
          Spacer(),
          Text(
            content,
            style: contentStyle ?? context.theme.textTheme.bodyLarge!.copyWith(
              color: context.textColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
