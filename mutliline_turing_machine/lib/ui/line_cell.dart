import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:provider/provider.dart';
import '../model/line_cell_model.dart';
import '../styles/app_colors.dart';

class LineCell extends StatefulWidget {
  const LineCell({
    required this.lineIndex,
    required this.index,
    Key? key,
  }) : super(key: key);

  final int lineIndex;
  final int index;
  @override
  State<LineCell> createState() => LineCellState();
}

class LineCellState extends State<LineCell> /*with SingleTickerProviderStateMixin*/ {
  // late Animation<Color?> animation;
  // late AnimationController controller;
  // late Color cellColor = AppColors.background;
  // @override
  // void initState() {
  //   super.initState();
  //   controller = AnimationController(
  //       duration: const Duration(milliseconds: 300), vsync: this);
  //   animation = ColorTween(begin: AppColors.background, end: AppColors.accent)
  //       .animate(controller)
  //     ..addListener(() {
  //       setState(() {
  //         cellColor = animation.value ?? cellColor;
  //       });
  //     });
  // }

  @override
  Widget build(BuildContext build) {
    var machine = MachineInherit.of(context)!.machine;
    var lineFocus = MachineInherit.of(context)!.linesFocus[widget.lineIndex];
    var linePage = MachineInherit.of(context)!.linesPageState;
    return Consumer<LineCellModel>(builder: (_, value, __) {
      // if (!controller.isAnimating) {
      //   if (value.isActive) {
      //     controller.forward();
      //   } else if(controller.isCompleted) {
      //     controller.reverse();
      //   }
      // }
      return GestureDetector(
        onTap: () {
          lineFocus.requestFocus();
          
        },
        onDoubleTap: () {
          var offset = widget.index - machine.configuration.linePointers[widget.lineIndex];
          machine.configuration.moveLine(widget.lineIndex, offset);
          linePage.currentState!.scrollLine(index:widget.lineIndex, offset: offset);
        },
        child: Align(
          alignment: const Alignment(0.0, 0.0),
          child: SizedBox(
            width: 28.0,
            height: 42.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: Container(
                decoration: !value.isActive
                    ? BoxDecoration(
                        border: Border.all(width: 2, color: AppColors.highlight),
                        borderRadius: const BorderRadius.all(Radius.circular(7)),
                        color: AppColors.background,
                      )
                    : BoxDecoration(
                        color: AppColors.accent,
                      ),
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Text(
                        value.symbol == " " ? "_" : value.symbol,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: !value.isActive
                              ? value.symbol == " "
                                  ? AppColors.disable
                                  : AppColors.text
                              : AppColors.background,
                        ),
                      ),
                      value.isFocus
                          ? Container(
                              width: 16.0,
                              height: 3.0,
                              margin: const EdgeInsets.only(
                                top: 32,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Container(
                                  decoration: BoxDecoration(color: value.isActive ? AppColors.background : AppColors.accent),
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
