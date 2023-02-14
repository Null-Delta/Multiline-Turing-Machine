import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:provider/provider.dart';
import '../model/line_cell_model.dart';
import 'snackbar.dart';

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
    var linePage = MachineInherit.of(context)!.linesPageState;
    return Consumer<LineCellModel>(builder: (_, value, __) {
      return GestureDetector(
        onTapDown: (_) {
          if (!machine.activator.isActive) {
            machine.configuration.setFocus(widget.lineIndex, widget.index);
            lineFocus.requestFocus();
            linePage.currentState!.scrollLineToFocus();
          } else {
            Snackbar.create(
                "Нельзя переназначать ячейку ввода т.к. машина работает.",
                context);
          }
        },
        onSecondaryTap: () {
          if (!machine.activator.isActive) {
            lineFocus.requestFocus();
            var offset = widget.index -
                machine.configuration.linePointers[widget.lineIndex];
            machine.configuration.moveLine(widget.lineIndex, offset);
            machine.configuration.setFocus(widget.lineIndex, widget.index);
            linePage.currentState!
                .scrollLine(index: widget.lineIndex, offset: offset);
          } else {
            Snackbar.create(
                "Нельзя переназначать активную ячейку т.к. машина работает.",
                context);
          }
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
                        border: Border.all(
                            width: 2, color: Theme.of(context).highlightColor),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
                        color: Theme.of(context).colorScheme.background,
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
                              : Theme.of(context).colorScheme.background,
                        ),
                      ),
                      value.isFocus
                          ? Container(
                              width: 14.0,
                              height: 3.0,
                              margin: const EdgeInsets.only(
                                top: 30,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(7),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: value.isActive
                                          ? Theme.of(context)
                                              .colorScheme
                                              .background
                                          : Theme.of(context).primaryColor),
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
