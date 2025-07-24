import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';

extension TextStyleExt on TextStyle {
  TextStyle get peach => copyWith(color: Colours.lightButtonHover);
  TextStyle get white => copyWith(color: Color(0xFFFFFFFF));
  TextStyle get rosyBrown => copyWith(color: Colours.brandSecondary);
  TextStyle get offWhite => copyWith(color: Colours.lightHeroBackground);
  TextStyle get brownTint => copyWith(color: Colours.darkAccentPinkMuted);
  TextStyle get grey => copyWith(color: Colors.grey);
  TextStyle primaryTextAdapter(BuildContext context) =>
      copyWith(color: Colours.classicAdaptiveTextColor(context));
  TextStyle secondaryTextAdapter(BuildContext context) =>
      copyWith(color: Colours.classicAdaptiveSecondaryTextColor(context));
}
