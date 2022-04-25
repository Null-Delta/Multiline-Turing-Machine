import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/ui/turing_machine_table.dart';

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
      required this.bottomSplitState})
      : super(child: child, key: key);

  final TuringMachine machine;

  final List<FocusNode> linesFocus;
  final FocusNode commentsFocus;

  final GlobalKey<LinesPageState> linesPageState;
  final GlobalKey<TuringMachineTableState> tableState;
  final GlobalKey<BottomSplitPanelState> bottomSplitState;

  @override
  bool updateShouldNotify(covariant MachineInherit oldWidget) {
    log("ShouldNotify");
    return linesFocus.length != oldWidget.linesFocus.length;
  }

  static MachineInherit? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MachineInherit>();
}
