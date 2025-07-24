import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';

abstract class TextStyles {
  static TextStyle lightHeaderBold = TextStyle(
    // headlineBold
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: Colours.lightTextSecondary,
    height: 1.2,
  );
  static TextStyle darkHeaderBold = lightHeaderBold.copyWith(
    color: Colours.darkTextSecondary,
  );
  static TextStyle headerBold1 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.5,
  );
  static TextStyle lightHeaderRegular = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: Colours.lightTextPrimary,
  );
  static TextStyle darkHeaderRegular = lightHeaderRegular.copyWith(
    color: Colours.darkTextPrimary,
  );
  static TextStyle lightParagraphSubTextRegular1 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: Colours.lightTextPrimary,
  );
  static TextStyle darkParagraphSubTextRegular1 = lightParagraphSubTextRegular1
      .copyWith(color: Colours.darkTextPrimary);

  static TextStyle paragraphSubTextRegular2 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle paragraphSubTextRegular3 = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w300,
    height: 1.5,
  );
  static TextStyle headerBold2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );
  static TextStyle lightHeaderBold3 = TextStyle(
    // headerBold3
    fontSize: 34,
    fontWeight: FontWeight.w600,
    height: 1.5,
    color: Colours.lightTextPrimary,
  );
  static TextStyle darkHeaderBold3 = lightHeaderBold3.copyWith(
    color: Colours.darkTextPrimary,
  );
  static TextStyle headerRegBold = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );
  static TextStyle lightHeadersemiBold = TextStyle(
    //headersemiBold
    fontSize: 20,
    fontWeight: FontWeight.w700,
    height: 1.5,
    color: Colours.lightTextPrimary,
  );
  static TextStyle darkHeadersemiBold = lightHeadersemiBold.copyWith(
    color: Colours.darkTextPrimary,
  );
  static TextStyle headersemiBold1 = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w500,
    height: 1.5,
  );
  static TextStyle appLogo = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w700,
  );
}
