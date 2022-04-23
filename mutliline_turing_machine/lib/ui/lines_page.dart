import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  bool isInFocus = false;
  int tapCount = 0;

  late FocusNode focus = FocusNode();
  @override
  Widget build(BuildContext context) {
    machine = MachineInherit.of(context)!.machine;

    return Expanded(
        // child: Focus(
        //   focusNode: focus,
        //   onFocusChange: (value) {
        //     tapCount = 0;
        //     setState(() {
        //       isInFocus = value;
        //     });
        //   },
        //   canRequestFocus: true,
        //   descendantsAreFocusable: false,
        //   onKey: (node, event) {
        //     if (event.isKeyPressed(LogicalKeyboardKey.arrowDown) || event.isKeyPressed(LogicalKeyboardKey.tab)) {
        //       tapCount++;
        //     } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
        //       tapCount--;
        //     }

        //     if (tapCount >= machine.model.countOfLines || tapCount < 0) {
        //       tapCount = machine.model.countOfLines - 1;
        //       return KeyEventResult.ignored;
        //     }
        //      else {
        //       return KeyEventResult.skipRemainingHandlers;
        //     }
        //   },
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                color: AppColors.backgroundDark,
                border: Border.all(
                  color:
                      isInFocus ? AppColors.accent : AppColors.backgroundDark,
                  width: 1,
                )),
            child: Column(
              children: lines,
            ),
          ),
        );
     // ),
    
  }
}
