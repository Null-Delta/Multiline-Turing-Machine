import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import 'app_colors.dart';

PlutoGridConfiguration tableConfiguration = PlutoGridConfiguration(
  rowHeight: 42,
  gridBackgroundColor: AppColors.background,
  gridBorderColor: AppColors.highlight,
  columnHeight: 36,
  enableGridBorderShadow: false,
  borderColor: Colors.transparent,
  activatedColor: AppColors.backgroundDark,
  activatedBorderColor: AppColors.highlight,
  enableColumnBorder: false,
  cellColorInReadOnlyState: AppColors.highlight,
  inactivatedBorderColor: AppColors.highlight,
  iconColor: AppColors.text,
  defaultCellPadding: 0,
  enableRowColorAnimation: false,
  cellTextStyle: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  ),
  columnTextStyle: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  ),
);
