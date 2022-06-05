import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:provider/provider.dart';
import '../model/line_cell_model.dart';

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

class LineCellState extends State<LineCell> {
  @override
  Widget build(BuildContext build) {
    var machine = MachineInherit.of(context)!.machine;
    var lineFocus = MachineInherit.of(context)!.linesFocus[widget.lineIndex];

    return Consumer<LineCellModel>(builder: (_, value, __) {
      return GestureDetector(
        onTap: () {
          lineFocus.requestFocus();
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
                        border: Border.all(width: 2, color: Theme.of(context).highlightColor),
                        borderRadius: const BorderRadius.all(Radius.circular(7)),
                        color: Theme.of(context).backgroundColor,
                      )
                    : BoxDecoration(
                        color: Theme.of(context).primaryColor,
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
                                  ? Theme.of(context).disabledColor
                                  : Theme.of(context).cardColor
                              : Theme.of(context).backgroundColor,
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
                                  decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
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
