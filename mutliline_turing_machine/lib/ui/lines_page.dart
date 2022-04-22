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

  late FocusNode focus;
  @override
  Widget build(BuildContext context) {
    machine = MachineInherit.of(context)!.machine;
    focus = MachineInherit.of(context)!.linesPageFocus;

    return Expanded(
      child: GestureDetector(
        excludeFromSemantics: false,
        onTap: () {
          
          if (!focus.hasFocus) {
            focus.requestFocus();
          }
        },
        child: Focus(
          focusNode: focus,
          onFocusChange: (value) {
            setState(() {
              isInFocus = value;
            });
          },
          canRequestFocus: true,
          descendantsAreFocusable: false,
          onKey: (node, event) {
            if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
              tapCount += 1;
            }
            if (tapCount > 5) {
              tapCount = 0;
              //FocusScope.of(context).focusInDirection(TraversalDirection.down);
              FocusScope.of(context).nextFocus();
              return KeyEventResult.ignored;
            } else {
              return KeyEventResult.skipRemainingHandlers;
            }
          },
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
              color: isInFocus ? AppColors.accent : AppColors.background,
              width: 10,
            )),
            constraints: const BoxConstraints(maxHeight: double.infinity),
            //color: AppColors.backgroundDark,
            child: Column(
              children: lines,
            ),
          ),
        ),
      ),
    );
  }
}
