import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';

PlutoGridConfiguration getConfig(BuildContext context) {
  log("config update");
  return PlutoGridConfiguration(
    rowHeight: 42,
    gridBackgroundColor: Colors.transparent,
    gridBorderColor: Theme.of(context).highlightColor,
    columnHeight: 36,
    enableGridBorderShadow: false,
    borderColor: Colors.transparent,
    activatedColor: Theme.of(context).hoverColor,
    activatedBorderColor: Theme.of(context).highlightColor,
    enableColumnBorder: false,
    cellColorInReadOnlyState: Theme.of(context).highlightColor,
    inactivatedBorderColor: Theme.of(context).highlightColor,
    iconColor: Theme.of(context).cardColor,
    defaultCellPadding: 0,
    enableRowColorAnimation: false,
    cellTextStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).cardColor,
    ),
    columnTextStyle: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: Theme.of(context).cardColor,
    ),
  );
}
