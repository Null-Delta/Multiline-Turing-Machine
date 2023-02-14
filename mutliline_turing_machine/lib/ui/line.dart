import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:mutliline_turing_machine/ui/settings_panel.dart';
import 'package:provider/provider.dart';
import '../scrollAbleList/scrollable_positioned_list.dart';
import 'line_cell.dart';
import 'dart:math' as math;

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

  late LineAnimationState animationState;
  int cellCount = 2003;
  ItemScrollController control = ItemScrollController();

  int lastIndexToScroll = 1001;

  int i = 0;
  scroll({int offset = 0, int speed = 1}) {
    if (animationState.isAnimate || false) {
      if (lastIndexToScroll !=
          machine.configuration.linePointers[widget.index] + 1) {
        if (widget.index == 0) {
          log("line" + (i++).toString());
        }

        lastIndexToScroll =
            machine.configuration.linePointers[widget.index] + 1;
        control.scrollTo(
            index: machine.configuration.linePointers[widget.index] + 1,
            alignment: 0.5,
            curve: Curves.easeOutQuad,
            myIndent: _widthOfCell / 2,
            duration: Duration(
                milliseconds:
                    (350 + (offset * 20).abs()) ~/ math.pow(speed, 1 / 3)));
      }
    } else {
      if (control.getLastIndex() !=
          machine.configuration.linePointers[widget.index] + 1) {
        control.jumpTo(
            index: machine.configuration.linePointers[widget.index] + 1,
            alignment: 0.5,
            myIndent: _widthOfCell / 2);
      }
    }
  }

  scrollToFocus({int offset = 0}) {
    if (machine.configuration.focusedLine == widget.index) {
      if (animationState.isAnimate) {
        if (lastIndexToScroll != machine.configuration.focusedIndex + 1) {
          lastIndexToScroll = machine.configuration.focusedIndex + 1;
          control.scrollTo(
              index: machine.configuration.focusedIndex + 1,
              alignment: 0.5,
              curve: Curves.easeOutQuad,
              myIndent: _widthOfCell / 2,
              duration: Duration(milliseconds: 350 + (offset * 20).abs()));
        }
      } else {
        if (machine.configuration.focusedIndex !=
            machine.configuration.focusedIndex + 1) {
          control.jumpTo(
              index: machine.configuration.focusedIndex + 1,
              alignment: 0.5,
              myIndent: _widthOfCell / 2);
        }
      }
    }
  }

  jumpToStart() {
    control.jumpTo(
        index: machine.configuration.linePointers[widget.index] + 1,
        alignment: 0.5,
        myIndent: _widthOfCell / 2);
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
            padding: index == 2002
                ? const EdgeInsets.only(left: 280)
                : const EdgeInsets.only(right: 280),
            child: Center(
              child: Text(
                "А все! ( ͡ʘ ͜ʖ ͡ʘ)",
                style: TextStyle(
                  color: Theme.of(context).cardColor,
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
                value: machine.configuration.lineContent[widget.index]
                    [index - 1],
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
                          style: TextStyle(
                            color: Theme.of(context).cardColor,
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
    log("I Line number " + widget.index.toString());
    machine = MachineInherit.of(context)!.machine;
    focus = MachineInherit.of(context)!.linesFocus[widget.index];
    animationState = MachineInherit.of(context)!.animationState;
    if (control.isAttached) {
      // control.jumpTo(
      //     index: machine.configuration.linePointer[widget.index],
      //     alignment: 0.5,
      //     myIndent: _widthOfCell / 2);
    }

    return GestureDetector(
      onTap: () {
        //focus.requestFocus();
      },
      child: Align(
        alignment: Alignment.center,
        child: Focus(
          onFocusChange: (value) {
            setState(() {
              machine.configuration.setFocusLine(widget.index, value);

              if (!machine.activator.isActive) {
                if (value) {
                  scrollToFocus();
                } else {
                  scroll();
                }
              }
            });
          },
          focusNode: focus,
          onKey: (node, event) {
            if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
              machine.configuration.moveLineInput(1);
            } else if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
              machine.configuration.moveLineInput(-1);
            } else if (event.isKeyPressed(LogicalKeyboardKey.backspace)) {
              machine.configuration.clearSymbol();
            } else if (event.character != null &&
                event.character != "_" &&
                event.character != "*" &&
                !event.isKeyPressed(LogicalKeyboardKey.arrowUp) &&
                !event.isKeyPressed(LogicalKeyboardKey.arrowDown) &&
                !event.isKeyPressed(LogicalKeyboardKey.tab) &&
                !event.isKeyPressed(LogicalKeyboardKey.enter)) {
              machine.configuration.writeSymbol(event.character!);
            } else {
              return KeyEventResult.ignored;
            }

            if (!machine.activator.isActive) {
              scrollToFocus();
            }
            return KeyEventResult.skipRemainingHandlers;
          },
          child: Container(
            decoration: BoxDecoration(color: Theme.of(context).hoverColor),
            width: MediaQuery.of(context).size.width,
            height: 67,
            child: line,
          ),
        ),
      ),
    );
  }
}
