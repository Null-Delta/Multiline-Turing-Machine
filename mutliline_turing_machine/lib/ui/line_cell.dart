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
  State<LineCell> createState() => _LineCellState();
}

class _LineCellState extends State<LineCell> {
  late TuringMachine machine;
  late FocusNode lineFocus;

  @override
  Widget build(BuildContext build) {
    machine = MachineInherit.of(context)!.machine;
    lineFocus = MachineInherit.of(context)!.lineFocus[widget.lineIndex];

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
                        border:
                            Border.all(width: 2, color: AppColors.highlight),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(7)),
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
                                  decoration: BoxDecoration(
                                      color: AppColors.background),
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
