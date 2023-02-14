import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/styles/app_colors.dart';

ThemeData light = ThemeData(
  primaryColor: AppColors.accent,
  disabledColor: AppColors.disable,
  highlightColor: AppColors.highlight,
  hoverColor: AppColors.backgroundDark,
  cardColor: AppColors.text,
  shadowColor: AppColors.shadowColor,
  fontFamily: "Inter",
  colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(AppColors.accent.value, {
    50: AppColors.accent,
    100: AppColors.accent,
    200: AppColors.accent,
    300: AppColors.accent,
    400: AppColors.accent,
    500: AppColors.accent,
    600: AppColors.accent,
    700: AppColors.accent,
    800: AppColors.accent,
    900: AppColors.accent,
  }))
      .copyWith(background: AppColors.background)
      .copyWith(error: AppColors.destructive),
);

ThemeData dark = ThemeData(
  primaryColor: AppDarkColors.accent,
  disabledColor: AppDarkColors.disable,
  highlightColor: AppDarkColors.highlight,
  hoverColor: AppDarkColors.backgroundDark,
  cardColor: AppDarkColors.text,
  shadowColor: AppDarkColors.shadowColor,
  fontFamily: "Inter",
  colorScheme: ColorScheme.fromSwatch(
          primarySwatch: MaterialColor(AppColors.accent.value, {
    50: AppColors.accent,
    100: AppColors.accent,
    200: AppColors.accent,
    300: AppColors.accent,
    400: AppColors.accent,
    500: AppColors.accent,
    600: AppColors.accent,
    700: AppColors.accent,
    800: AppColors.accent,
    900: AppColors.accent,
  }))
      .copyWith(background: AppDarkColors.background)
      .copyWith(error: AppDarkColors.destructive),
);
