import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:mutliline_turing_machine/ui/line.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';

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

  void clearAllLines() {
    for (int i = 0; i < countOfLines; i++) {
      for (int j = 0; j < machine.configuration.lineContent[i].length; j++) {
        machine.configuration.lineContent[i][j].setSymbol(" ");
      }
      var dif = 1000 - machine.configuration.linePointers[i];
      machine.configuration.moveLine(i, dif);
      linesState[i].currentState?.jumpToStart();
    }
  }

  int i = 0;
  void onScroll() {
    //log("onScroll " + (i++).toString());
    for (int i = 0; i < linesState.length; i++) {
      linesState[i]
          .currentState
          ?.scroll(speed: machine.activator.timesPerSecond);
    }
  }

  void scrollLine({required int index, int offset = 0}) {
    linesState[index].currentState?.scroll(offset: offset);
  }

  void scrollLineToFocus() {
    linesState[machine.configuration.focusedLine].currentState?.scrollToFocus();
  }

  Future<void> reBuild() async {
    setState(() {
      MachineInherit.of(context)!.linesFocus.clear();
      for (int i = 0; i < countOfLines; i++) {
        MachineInherit.of(context)!.linesFocus.add(FocusNode());
      }
      countOfLines = MachineInherit.of(context)!.machine.model.countOfLines;
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
    });
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
    log("lines " +
        lines.length.toString() +
        " Count " +
        countOfLines.toString() +
        " focuses " +
        MachineInherit.of(context)!.linesFocus.length.toString() +
        " linesStates " +
        linesState.length.toString());
    //Добавление/удаление лент
    if (lines.length != countOfLines) {
      for (int i = 0; i < (lines.length - countOfLines).abs(); i++) {
        lines.length < countOfLines
            ? {
                linesState.add(GlobalKey<LineState>()),
                lines.add(
                  Line(
                    index: lines.length,
                    key: linesState[lines.length],
                  ),
                ),
                //MachineInherit.of(context)!.linesFocus.add(FocusNode()),
              }
            : {
                lines.removeLast(),
                linesState.removeLast(),
                //MachineInherit.of(context)!.linesFocus.removeLast(),
              };
      }
    }

    return Expanded(
      child: Container(
        color: Theme.of(context).hoverColor,
        width: double.infinity,
        child: lines.isNotEmpty
            ? ListView.builder(
                controller: ScrollController(),
                itemCount: lines.length,
                itemBuilder: (context, index) {
                  return lines[index];
                })
            : Image(
                image: AppImages.confused,
                color: Theme.of(context).dividerColor,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
