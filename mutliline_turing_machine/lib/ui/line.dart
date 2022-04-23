import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_colors.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:provider/provider.dart';
import '../scrollAbleList/scrollable_positioned_list.dart';
import 'line_cell.dart';

class Line extends StatefulWidget {
  const Line({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  LineState createState() => LineState();
}

class LineState extends State<Line> {
  static const double _widthOfCell = 28;
  static const double _widthOfSeparator = 4;

  late TuringMachine machine;
  late FocusNode focus;

  int cellCount = 2001;
  ItemScrollController control = ItemScrollController();

  scroll() {
    //log("scrooooooooool: ${machine.linePointer[widget.index]}");
    control.scrollTo(
        index: machine.linePointer[widget.index],
        alignment: 0.5,
        myIndent: _widthOfCell / 2,
        duration: const Duration(milliseconds: 100));
    // control.jumpTo(
    //     index: widget.machine.linePointer[widget.index],
    //     alignment: 0.5,
    //     myIndent: _widthOfCell / 2);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      control.jumpTo(
          index: cellCount ~/ 2, alignment: 0.5, myIndent: _widthOfCell / 2);
    });
  }

  late var line = ScrollablePositionedList.separated(
      itemScrollController: control,
      scrollDirection: Axis.horizontal,
      itemCount: cellCount,
      initialScrollIndex: 0,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            ChangeNotifierProvider.value(
              value: machine.lineContent[widget.index][index],
              child: LineCell(
                lineIndex: widget.index,
                index: index,
              ),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(0, 56, 0, 0),
                child: SizedBox(
                    width: 28,
                    height: 20,
                    child: Text((index - cellCount ~/ 2).toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF183157),
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 8,
                        ))))
          ],
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: _widthOfSeparator);
      });

  @override
  Widget build(BuildContext context) {
    machine = MachineInherit.of(context)!.machine;
    focus = MachineInherit.of(context)!.lineFocus[widget.index];
    if (control.isAttached) {
      control.jumpTo(
          index: machine.linePointer[widget.index],
          alignment: 0.5,
          myIndent: _widthOfCell / 2);
    }

    return GestureDetector(
      onTap: () {
        focus.requestFocus();
      },
      child: Align(
        alignment: Alignment.center,
        child: Focus(
          onFocusChange: (value) {
            setState(() {
              machine.setFocus(widget.index, value);
            });
          },
          focusNode: focus,
          onKey: (node, event) {
            if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
              machine.moveLine(widget.index, event.isShiftPressed ? 4 : 1);
              scroll();
            } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
              machine.moveLine(widget.index, event.isShiftPressed ? -4 : -1);
              scroll();
            } else if (event.isKeyPressed(LogicalKeyboardKey.backspace)) {
              machine.clearSymbol(widget.index);
              scroll();
            } else if (event.character != null) {
              machine.writeSymbol(widget.index, event.character!);
              scroll();
            }

            return KeyEventResult.ignored;
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundDark,
              // border: Border.all(
              //   color: focus.hasFocus ? AppColors.accent : AppColors.backgroundDark,
              // ),
            ),
            width: MediaQuery.of(context).size.width,
            height: 67,
            child: line,
          ),
        ),
      ),
    );
  }
}
