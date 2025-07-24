import 'package:e_triad/core/res/colours.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color _lightSeedColor = Colours.darkAccentPink;
  static const Color _darkSeedColor = Colours.darkSchemeColor;
  // Color.fromARGB(86, 175, 167, 216) Color.fromARGB(83, 0, 255, 242)
  static final ColorScheme _lightColorScheme = ColorScheme.fromSeed(
    seedColor: _lightSeedColor,
    brightness: Brightness.light,
  );

  static final ColorScheme _darkColorScheme = ColorScheme.fromSeed(
    seedColor: _darkSeedColor,
    brightness: Brightness.dark,
  );

  static ThemeData _baseTheme(ColorScheme colorScheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      fontFamily: 'Switzer',

      scaffoldBackgroundColor: colorScheme.surface,

      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        titleTextStyle: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 26,
          fontWeight: FontWeight.w600,
          fontFamily: 'Switzer',
        ),
      ),
      
      drawerTheme: DrawerThemeData(
        backgroundColor: colorScheme.surface,

      ),

      inputDecorationTheme: InputDecorationTheme(
        fillColor: colorScheme.surfaceContainerHighest,
        filled: true,
        errorStyle: TextStyle(color: colorScheme.error, fontSize: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        circularTrackColor: colorScheme.onSecondary
      ),

      searchBarTheme: SearchBarThemeData(
        backgroundColor: WidgetStateProperty.all(colorScheme.surfaceContainer),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        elevation: WidgetStateProperty.all(0.0),
        constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            color: colorScheme.onSurface,
            fontSize: 16,
            fontFamily: 'Switzer',
          ),
        ),
        hintStyle: WidgetStateProperty.all(
          TextStyle(
            color: colorScheme.onSurfaceVariant,
            fontSize: 16,
            fontFamily: 'Switzer',
          ),
        ),
      ),
    );
  }

  static ThemeData get lightTheme => _baseTheme(_lightColorScheme);
  static ThemeData get darkTheme => _baseTheme(_darkColorScheme);

  // static ThemeData lightMode() {
  //   final lightTheme = ThemeData(
  //     primaryColor: Colours.darkAccentPink,

  //     inputDecorationTheme: InputDecorationTheme(
  //       fillColor: Colours.lightSurface,
  //       errorStyle: TextStyle(color: Colours.lightError, fontSize: 10),
  //     ),
  //     iconTheme: IconThemeData(color: Colors.white),

  //     searchBarTheme: SearchBarThemeData(
  //       hintStyle: WidgetStateProperty.all(
  //         TextStyles.paragraphSubTextRegular2.copyWith(color: Colors.grey),
  //       ),
  //       textStyle: WidgetStateProperty.all(
  //         TextStyles.lightParagraphSubTextRegular1.copyWith(
  //           color: Colours.lightTextPrimary,
  //         ),
  //       ),
  //       backgroundColor: WidgetStateProperty.all(Colours.lightSurface),
  //       shadowColor: WidgetStateProperty.all(Colors.transparent),
  //       elevation: WidgetStateProperty.all(0.0),
  //       constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
  //       shape: WidgetStateProperty.all(
  //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  //       ),
  //     ),
  //     searchViewTheme: SearchViewThemeData(
  //       backgroundColor: Colours.lightBackground,
  //       elevation: 0.0,
  //       constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  //       headerTextStyle: TextStyles.lightHeaderRegular,
  //       barPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
  //       headerHintStyle: TextStyles.lightParagraphSubTextRegular1,
  //     ),
  //     textTheme: TextTheme(
  //       displaySmall: TextStyles.lightHeaderBold,
  //       titleLarge: TextStyles.appLogo,
  //       headlineLarge: TextStyles.lightHeaderBold3,
  //       headlineMedium: TextStyles.lightHeadersemiBold,
  //       bodyLarge: TextStyles.lightHeaderRegular,
  //       bodyMedium: TextStyles.lightParagraphSubTextRegular1,
  //       bodySmall: TextStyles.paragraphSubTextRegular2,
  //       labelLarge: TextStyles.paragraphSubTextRegular3,
  //     ),
  //     filledButtonTheme: FilledButtonThemeData(
  //       style: FilledButton.styleFrom(
  //         backgroundColor: Colours.darkBottomButton,
  //       ),
  //     ),
  //     useMaterial3: true,
  //     brightness: Brightness.light,
  //     colorScheme: ColorScheme.fromSeed(seedColor: Colours.darkAccentPink),
  //     fontFamily: 'Switzer',
  //     scaffoldBackgroundColor: Colours.lightBackground,
  //     appBarTheme: AppBarTheme(
  //       backgroundColor: Colours.lightTintBackground,
  //       foregroundColor: Colours.lightTextPrimary,
  //       titleTextStyle: TextStyle(
  //         color: Colours.lightTextPrimary,
  //         fontSize: 26,
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //   );
  //   return lightTheme;
  // }

  // static ThemeData darkMode() {
  //   final darkTheme = lightMode().copyWith(
  //     brightness: Brightness.dark,
  //     primaryColor: Colours.darkButtonSecondary,
  //     textTheme: TextTheme(
  //       titleLarge: TextStyles.appLogo,
  //       displaySmall: TextStyles.darkHeaderBold,
  //       headlineLarge: TextStyles.darkHeaderBold3,
  //       headlineMedium: TextStyles.darkHeadersemiBold,
  //       bodyLarge: TextStyles.darkHeaderRegular,
  //       bodyMedium: TextStyles.darkParagraphSubTextRegular1,
  //     ),
  //     searchBarTheme: SearchBarThemeData(
  //       hintStyle: WidgetStateProperty.all(
  //         TextStyles.paragraphSubTextRegular2.copyWith(color: Colors.grey),
  //       ),
  //       textStyle: WidgetStateProperty.all(
  //         TextStyles.darkParagraphSubTextRegular1.copyWith(
  //           color: Colours.darkTextPrimary,
  //         ),
  //       ),
  //       backgroundColor: WidgetStateProperty.all(Colours.darkInputBackground),
  //       shadowColor: WidgetStateProperty.all(Colors.transparent),
  //       elevation: WidgetStateProperty.all(0.0),
  //       constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
  //       shape: WidgetStateProperty.all(
  //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  //       ),
  //     ),
  //     searchViewTheme: SearchViewThemeData(
  //       backgroundColor: Colours.darkBackground,
  //       headerTextStyle: TextStyles.darkHeaderRegular,
  //       elevation: 0.0,
  //       constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
  //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
  //       barPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
  //       headerHintStyle: TextStyles.darkParagraphSubTextRegular1.copyWith(
  //         color: Colors.grey,
  //       ),
  //     ),

  //     iconTheme: IconThemeData(color: Colours.brandPrimary),
  //     inputDecorationTheme: InputDecorationTheme(
  //       fillColor: Colours.darkInputBackground,
  //       errorStyle: TextStyle(color: Colours.darkError, fontSize: 10),
  //     ),
  //     filledButtonTheme: FilledButtonThemeData(
  //       style: FilledButton.styleFrom(
  //         backgroundColor: Colours.darkButtonSecondary,
  //       ),
  //     ),
  //     scaffoldBackgroundColor: Colours.darkBackground,
  //     colorScheme: ColorScheme.fromSeed(seedColor: Colours.darkButtonSecondary),
  //     appBarTheme: AppBarTheme(
  //       backgroundColor: Colours.darkTintBackground,
  //       foregroundColor: Colours.darkTextPrimary,
  //       titleTextStyle: TextStyle(
  //         color: Colours.darkTextPrimary,
  //         fontSize: 26,
  //         fontWeight: FontWeight.w600,
  //       ),
  //     ),
  //   );
  //   return darkTheme;
  // }
}
