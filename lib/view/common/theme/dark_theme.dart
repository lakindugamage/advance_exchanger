
import 'package:advance_exchanger/view/common/color/custom_colors.dart';
import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: CustomColor.darkBlack,
  primaryColor: CustomColor.blue,
  appBarTheme: const AppBarTheme(
    backgroundColor: CustomColor.transparent,
    scrolledUnderElevation: 0,
  ),

  // Text Theme
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: CustomColor.white,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: CustomColor.white,
      fontSize: 26,
      fontWeight: FontWeight.w600,
    ),
    titleSmall: TextStyle(
      color: CustomColor.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      color: CustomColor.white,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    bodyMedium: TextStyle(
      color: CustomColor.lightGrey,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      color: CustomColor.white,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
  ),
);
