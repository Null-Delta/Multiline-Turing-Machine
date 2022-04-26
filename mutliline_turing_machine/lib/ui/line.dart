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

  int cellCount = 2003;
  ItemScrollController control = ItemScrollController();

  scroll() {
    control.scrollTo(
        index: machine.configuration.linePointers[widget.index] + 1,
        alignment: 0.5,
        curve: Curves.easeOutQuad,
        myIndent: _widthOfCell / 2,
        duration: const Duration(milliseconds: 350));
  }

  jumpToStart() {
    control.jumpTo(
        index: machine.configuration.linePointers[widget.index] + 1, alignment: 0.5, myIndent: _widthOfCell / 2);
  }

  late var line = ScrollablePositionedList.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemScrollController: control,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 2000, right: 2000),
      itemCount: cellCount,
      initialScrollIndex: machine.configuration.linePointers[widget.index] + 1,
      itemBuilder: (context, index) {
        if (index == 2002 || index == 0) {
          return Container(
            padding: index == 2002 ? const EdgeInsets.only(left: 280) : const EdgeInsets.only(right: 280),
            child: Center(
              child: Text(
                "А все!",
                style: TextStyle(
                  color: AppColors.text,
                  fontWeight: FontWeight.normal,
                  fontSize: 20,
                ),
              ),
            ),
          );
        } else {
          return Stack(
            children: [
              ChangeNotifierProvider.value(
                value: machine.configuration.lineContent[widget.index][index - 1],
                child: LineCell(
                  lineIndex: widget.index,
                  index: index - 1,
                ),
              ),
              Container(
                  padding: const EdgeInsets.fromLTRB(0, 56, 0, 0),
                  child: SizedBox(
                      width: 28,
                      height: 20,
                      child: Text((index - 1 - (cellCount - 2) ~/ 2).toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF183157),
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 8,
                          ))))
            ],
          );
        }
      },
      separatorBuilder: (context, index) {
        return const SizedBox(width: _widthOfSeparator);
      });

  @override
  Widget build(BuildContext context) {
    machine = MachineInherit.of(context)!.machine;
    focus = MachineInherit.of(context)!.linesFocus[widget.index];
    if (control.isAttached) {
      // control.jumpTo(
      //     index: machine.configuration.linePointer[widget.index],
      //     alignment: 0.5,
      //     myIndent: _widthOfCell / 2);
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
              machine.configuration.setFocus(widget.index, value);
            });
          },
          focusNode: focus,
          onKey: (node, event) {
            if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
              machine.configuration.moveLine(widget.index, 1);
              scroll();
              return KeyEventResult.skipRemainingHandlers;
            } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
              machine.configuration.moveLine(widget.index, -1);
              scroll();
              return KeyEventResult.skipRemainingHandlers;
            } else if (event.isKeyPressed(LogicalKeyboardKey.backspace)) {
              machine.configuration.clearSymbol(widget.index);
              scroll();
              return KeyEventResult.skipRemainingHandlers;
            } else if (event.character != null &&
                event.character != "_" &&
                event.character != "*" &&
                !event.isKeyPressed(LogicalKeyboardKey.arrowUp) &&
                !event.isKeyPressed(LogicalKeyboardKey.arrowDown) &&
                !event.isKeyPressed(LogicalKeyboardKey.tab) &&
                !event.isKeyPressed(LogicalKeyboardKey.enter)) {
              machine.configuration.writeSymbol(widget.index, event.character!);
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
