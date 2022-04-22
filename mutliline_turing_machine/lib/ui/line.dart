import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
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

  final FocusNode focusNode = FocusNode();

  late TuringMachine machine;

  scroll() {
    log("scrooooooooool: ${machine.linePointer[widget.index]}");
    control.scrollTo(
        index: machine.linePointer[widget.index],
        duration: const Duration(milliseconds: 250));
    // control.jumpTo(
    //     index: widget.machine.linePointer[widget.index],
    //     alignment: 0.5,
    //     myIndent: _widthOfCell / 2);
  }

  int cellCount = 2001;
  ItemScrollController control = ItemScrollController();

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

  //late LineCellModel item;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      control.jumpTo(
          index: cellCount ~/ 2, alignment: 0.5, myIndent: _widthOfCell / 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    machine = MachineInherit.of(context)!.machine;
    if (control.isAttached) {
      control.jumpTo(
          index: machine.linePointer[widget.index],
          alignment: 0.5,
          myIndent: _widthOfCell / 2);
    }

    return GestureDetector(
      onTap: () {},
      child: Align(
        alignment: Alignment.center,
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 67,
            child: GestureDetector(
                onTap: () {
                  log("message");
                },
                child: line)),
      ),
    );
  }
}
