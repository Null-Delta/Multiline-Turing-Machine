import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/ui/line.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import '../styles/app_colors.dart';

class LinesPage extends StatefulWidget {
  const LinesPage({Key? key}) : super(key: key);

  @override
  LinesPageState createState() => LinesPageState();
}

class LinesPageState extends State<LinesPage> {
  late TuringMachine machine;

  late var lines = [
    for (int i = 0; i < machine.model.countOfLines; i++)
      Line(
        index: i,
        key: linesState[i],
      ),
  ];

  late var linesState = [
    for (int i = 0; i < machine.model.countOfLines; i++) GlobalKey<LineState>(),
  ];

  void onScroll() {
    for (var element in linesState) {
      element.currentState!.scroll();
    }
  }

  @override
  Widget build(BuildContext context) {
    machine = MachineInherit.of(context)!.machine;

    return Expanded(
      child: Container(
        constraints: const BoxConstraints(maxHeight: double.infinity),
        color: AppColors.backgroundDark,
        child: Column(
          children: lines,
        ),
      ),
    );
  }
}
