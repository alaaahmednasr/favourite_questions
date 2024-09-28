import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../styles/styles.dart';

class Themes {
  ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: ColorPalette.backgroundColor,
    primaryColor: ColorPalette.primaryBlack,
    brightness: Brightness.light,
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      labelLarge: TextStyles.textStyleMedium35,
      bodyLarge: TextStyles.textStyleSemiBold16,
      labelMedium: TextStyles.textStyleMedium16,
      titleMedium: TextStyles.textStyleMedium25,
      labelSmall: TextStyles.textStyleMedium15,
    ),
    floatingActionButtonTheme:  FloatingActionButtonThemeData(
      backgroundColor: ColorPalette.primaryColor.withOpacity(0.5),
    ),
  );
}
