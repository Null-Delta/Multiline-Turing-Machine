import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';

import 'lines_page.dart';

class MachineInherit extends InheritedWidget {
   const MachineInherit(
      {Key? key,
      required Widget child,
      required this.machine,
      required this.lineFocus,
      required this.commentsFocus,
      required this.linesPageState})
      : super(child: child, key: key);

  final TuringMachine machine;

  final List<FocusNode> lineFocus;
  final FocusNode commentsFocus;

  final GlobalKey<LinesPageState> linesPageState;

  @override
  bool updateShouldNotify(covariant MachineInherit oldWidget) {
    log("ShouldNotify");
    return lineFocus.length != oldWidget.lineFocus.length;
  }

  static MachineInherit? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MachineInherit>();
}
