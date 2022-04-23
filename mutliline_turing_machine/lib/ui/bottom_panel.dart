import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import '../styles/app_colors.dart';

// ignore: must_be_immutable
class BottomPanel extends StatefulWidget {
  BottomPanel(
      {Key? key,
      required this.machine,
      required this.onAddVariant,
      required this.onDeleteVariant,
      required this.onAddState,
      required this.onDeleteState})
      : super(key: key);
  final TuringMachine machine;
  PlutoGridStateManager? tableManager;
  void Function() onAddVariant;
  void Function() onDeleteVariant;
  void Function() onAddState;
  void Function() onDeleteState;

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  static const double iconSize = 28;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 6,
            right: 6,
          ),
          height: 40,
          color: AppColors.background,
          child: Row(
            children: [
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Добавить состояние",
                child: ElevatedButton(
                  onPressed: () {
                    widget.onAddState();
                  },
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.addState,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Удалить состояние",
                child: ElevatedButton(
                  onPressed: () {
                    widget.onDeleteState();
                  },
                  child: const Image(
                    image: AppImages.deleteState,
                  ),
                  style: appButtonStyle,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Container(
                color: AppColors.highlight,
                width: 2,
                height: 16,
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Добавить вариант",
                child: ElevatedButton(
                  onPressed: () {
                    widget.onAddVariant();
                    //widget.tableManager!.getRowByIdx(0)!.cells["head:0"]
                  },
                  child: const Image(
                    image: AppImages.addVariantDown,
                  ),
                  style: appButtonStyle,
                ),
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Удалить вариант",
                child: ElevatedButton(
                  onPressed: () {
                    widget.onDeleteVariant();
                  },
                  child: const Image(
                    image: AppImages.deleteVariant,
                  ),
                  style: appButtonStyle,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Debug",
                child: ElevatedButton(
                  onPressed: () {
                    log(widget.machine.model.info());
                  },
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.help,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Debug 2",
                child: ElevatedButton(
                  onPressed: () {
                    log(widget.machine.info());
                  },
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.help,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Make step",
                child: ElevatedButton(
                  onPressed: () {
                    log(widget.machine.makeStep());
                  },
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.help,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Start/Stop Machine",
                child: ElevatedButton(
                  onPressed: () {
                    if (!widget.machine.activator.isActive){
                      widget.machine.activator.startMachine(3);
                    } else {
                      widget.machine.activator.stopMachine();
                    }
                  },
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.help,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 2,
          thickness: 2,
          color: AppColors.highlight,
        ),
      ],
    );
  }
}
