import 'dart:developer';

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

  late int countOfLines;

  late var linesState = [
    for (int i = 0; i < countOfLines; i++) GlobalKey<LineState>(),
  ];

  late var lines = [
    for (int i = 0; i < countOfLines; i++)
      Line(
        index: i,
        key: linesState[i],
      ),
  ];

  // void saveLines(){
  //   for (int i = 0; i < countOfLines; i++){
  //    linesState[i].currentState!.saveLine();
  //   }
  // }

  // void loadLines(){
  //   for (int i = 0; i < countOfLines; i++){
  //    linesState[i].currentState!.loadLine();
  //   }
  // }

  // void clearLines(){
  //   for (int i = 0; i < countOfLines; i++){
  //    linesState[i].currentState!.clearLine();
  //   }
  // }

  void onScroll() {
    for (var element in linesState) {
      element.currentState?.scroll();
    }
  }

  late List<FocusNode> linesFocus;
  @override
  Widget build(BuildContext context) {
    machine = MachineInherit.of(context)!.machine;
    countOfLines = MachineInherit.of(context)!.machine.model.countOfLines;

    //Добавление/удаление фокусов лент
    int focusCount = MachineInherit.of(context)!.linesFocus.length;
    if (focusCount != countOfLines) {
      for (int i = 0; i < (focusCount - countOfLines).abs(); i++) {
        focusCount < countOfLines
            ? MachineInherit.of(context)!.linesFocus.add(FocusNode())
            : MachineInherit.of(context)!.linesFocus.removeLast();
      }
    }

    //Добавление/удаление лент
    // if (lines.length != countOfLines) {
    //   for (int i = 0; i < (lines.length - countOfLines).abs(); i++) {
    //     lines.length < countOfLines
    //         ? {
    //             linesState.add(GlobalKey<LineState>()),
    //             lines.add(
    //               Line(
    //                 index: linesState.length - 1,
    //                 key: linesState[linesState.length - 1],
    //               ),
    //             )
    //           }
    //         : {lines.removeLast(), linesState.removeLast()};
    //   }
    // }

    linesState = [
      for (int i = 0; i < countOfLines; i++) GlobalKey<LineState>(),
    ];
    lines = [
      for (int i = 0; i < countOfLines; i++)
        Line(
          index: i,
          key: linesState[i],
        ),
    ];
    return Expanded(
      child: Container(
        color: AppColors.backgroundDark,
        child: ListView.builder(
            controller: ScrollController(),
            itemCount: lines.length,
            itemBuilder: (context, index) {
              return lines[index];
            }),
      ),
    );
  }
}
