import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';

class MachineInherit extends InheritedWidget {
  const MachineInherit(
      {Key? key,
      required Widget child,
      required this.machine,
      required this.lineFocus,
      required this.commentsFocus})
      : super(child: child, key: key);

  final TuringMachine machine;
  final List<FocusNode> lineFocus;
  final FocusNode commentsFocus;

  @override
  bool updateShouldNotify(covariant MachineInherit oldWidget) {
    return machine != oldWidget.machine;
  }

  static MachineInherit? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<MachineInherit>();
}
