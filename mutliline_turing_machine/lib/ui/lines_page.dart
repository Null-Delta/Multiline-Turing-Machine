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

  void onScroll() {
    for (var element in linesState) {
      element.currentState?.scroll();
    }
  }

  void checkChanges() {
    if (linesState.length < countOfLines) {
      linesState.add(GlobalKey<LineState>());
    } else if (linesState.length > countOfLines) {
      linesState.removeLast();
    }

    if (lines.length < countOfLines) {
      lines.add(
        Line(
          index: countOfLines - 1,
          key: linesState[countOfLines - 1],
        ),
      );
    } else if (lines.length > countOfLines) {
      lines.removeLast();
    }
  }

  late FocusNode focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    machine = MachineInherit.of(context)!.machine;
    countOfLines = MachineInherit.of(context)!.machine.model.countOfLines;

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
