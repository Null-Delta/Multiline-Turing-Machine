import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/ui/app_theme.dart';
import 'package:mutliline_turing_machine/ui/settings_panel.dart';
import 'package:mutliline_turing_machine/ui/states_list.dart';
import 'package:mutliline_turing_machine/ui/turing_machine_table.dart';

import 'bottom_panel.dart';
import 'bottom_split_panel.dart';
import 'lines_page.dart';

class MachineInherit extends InheritedWidget {
  const MachineInherit(
      {Key? key,
      required Widget child,
      required this.machine,
      required this.linesFocus,
      required this.commentsFocus,
      required this.linesPageState,
      required this.tableState,
      required this.statesListState,
      required this.bottomSplitState,
      required this.statesFocus,
      required this.animationState,
      required this.bottomPanel,
      required this.theme})
      : super(child: child, key: key);

  final TuringMachine machine;

  final List<FocusNode> linesFocus;
  final FocusNode commentsFocus;
  final FocusNode statesFocus;

  final GlobalKey<LinesPageState> linesPageState;
  final GlobalKey<TuringMachineTableState> tableState;
  final GlobalKey<BottomSplitPanelState> bottomSplitState;
  final GlobalKey<StatesListState> statesListState;
  final GlobalKey<BottomPanelState> bottomPanel;
  final LineAnimationState animationState;

  final AppTheme theme;

  @override
  bool updateShouldNotify(covariant MachineInherit oldWidget) {
    log("ShouldNotify");
    return linesFocus.length != oldWidget.linesFocus.length;
  }

  static MachineInherit? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MachineInherit>();
}
