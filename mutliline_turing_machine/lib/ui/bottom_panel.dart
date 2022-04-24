import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import '../styles/app_colors.dart';

// ignore: must_be_immutable
class BottomPanel extends StatefulWidget {
  BottomPanel(
      {Key? key,
      required this.onAddVariant,
      required this.onDeleteVariant,
      required this.onAddState,
      required this.onDeleteState,
      required this.onMakeStep,
      required this.onStartStopWork,
      required this.onCommentsShow})
      : super(key: key);
  PlutoGridStateManager? tableManager;
  void Function() onAddVariant;
  void Function() onDeleteVariant;
  void Function() onAddState;
  void Function() onDeleteState;
  void Function() onMakeStep;
  void Function() onStartStopWork;
  void Function() onCommentsShow;
  final FocusNode topFocus = FocusNode();

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  late TuringMachine machine;

  static const double iconSize = 28;

  @override
  Widget build(BuildContext context) {
    machine = MachineInherit.of(context)!.machine;
    var commentsState = MachineInherit.of(context)!.bottomSplitState;
    //commentsState.currentState!.comm
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
                  focusNode: widget.topFocus,
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
              Expanded(
                child: Container(
                  width: double.infinity,
                ),
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Debug",
                child: ElevatedButton(
                  onPressed: () {
                    log(machine.model.info());
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
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Запустить/Остановить машину",
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.onStartStopWork();
                    });
                  },
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      color: machine.activator.isActive
                          ? AppColors.background
                          : AppColors.text,
                      image: AppImages.timer,
                    ),
                  ),
                  style: machine.activator.isActive
                      ? activeAppButtonStyle
                      : appButtonStyle,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Сделать шаг",
                child: ElevatedButton(
                  onPressed: () {
                    widget.onMakeStep();
                  },
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.step,
                    ),
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
                message: "Комментарии",
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.onCommentsShow();
                    });
                  },
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      color:
                          commentsState.currentState?.needShowComments ?? true
                              ? AppColors.background
                              : AppColors.text,
                      image: AppImages.comments,
                    ),
                  ),
                  style: commentsState.currentState?.needShowComments ?? true
                      ? activeAppButtonStyle
                      : appButtonStyle,
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
