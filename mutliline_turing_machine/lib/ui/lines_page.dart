import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/ui/line.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import '../styles/app_colors.dart';
import 'dart:math';

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


  void clearAllLines()
  { 
    for(int i = 0; i < countOfLines; i++) {
      for (int j = 0; j < machine.configuration.lineContent[i].length; j++) {
        machine.configuration.lineContent[i][j].setSymbol(" ");
      }
      var dif = 1000 - machine.configuration.linePointers[i];
      machine.configuration.moveLine(i, dif);
      linesState[i].currentState?.jumpToStart();
    }
    
  }

  void onScroll() {
    for (int i = 0; i < linesState.length; i++) {
      linesState[i].currentState?.scroll();
    }
  }

  void scrollLine({required int index, int offset = 0}) {
      linesState[index].currentState?.scroll(offset: offset);
  }

  void scrollLineToFocus() {
      linesState[machine.configuration.focusedLine].currentState?.scrollToFocus();
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
