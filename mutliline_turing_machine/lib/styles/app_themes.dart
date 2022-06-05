import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/styles/app_colors.dart';

ThemeData light = ThemeData(
  primaryColor: AppColors.accent,
  errorColor: AppColors.destructive,
  disabledColor: AppColors.disable,
  highlightColor: AppColors.highlight,
  backgroundColor: AppColors.background,
  hoverColor: AppColors.backgroundDark,
  cardColor: AppColors.text,
  shadowColor: AppColors.shadowColor,
  fontFamily: "Inter",
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
  }),
);

ThemeData dark = ThemeData(
  primaryColor: AppDarkColors.accent,
  errorColor: AppDarkColors.destructive,
  disabledColor: AppDarkColors.disable,
  highlightColor: AppDarkColors.highlight,
  backgroundColor: AppDarkColors.background,
  hoverColor: AppDarkColors.backgroundDark,
  cardColor: AppDarkColors.text,
  shadowColor: AppDarkColors.shadowColor,
  fontFamily: "Inter",
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
  }),
);
