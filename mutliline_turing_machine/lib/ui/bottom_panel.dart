import 'dart:developer' as developer;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import 'package:mutliline_turing_machine/ui/bottom_split_panel.dart';
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
      required this.onNewSpeed,
      required this.onResetWork,
      required this.onCommentsShow})
      : super(key: key);
  PlutoGridStateManager? tableManager;
  void Function() onAddVariant;
  void Function() onDeleteVariant;
  void Function() onAddState;
  void Function() onDeleteState;
  void Function() onMakeStep;
  void Function() onResetWork;
  void Function(int timesPerSec) onStartStopWork;
  void Function(int timesPerSec) onNewSpeed;
  void Function() onCommentsShow;
  final FocusNode topFocus = FocusNode();

  @override
  State<BottomPanel> createState() => _BottomPanelState();
}

class _BottomPanelState extends State<BottomPanel> {
  late TuringMachine machine;

  static const double iconSize = 28;

  int timesPerSec= 4;

  late var addStateBtn = Tooltip(
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
  );

  late var deleteStateBtn = Tooltip(
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
  );

  late var addRuleBtn = Tooltip(
    waitDuration: const Duration(milliseconds: 500),
    message: "Добавить правило",
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
  );

  late var deleteRuleBtn = Tooltip(
    waitDuration: const Duration(milliseconds: 500),
    message: "Удалить правило",
    child: ElevatedButton(
      onPressed: () {
        widget.onDeleteVariant();
      },
      child: const Image(
        image: AppImages.deleteVariant,
      ),
      style: appButtonStyle,
    ),
  );

  late var spacer = const SizedBox(
    width: 6,
  );

  commentsBtn() {
    return Tooltip(
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
            color: commentsState.currentState?.needShowComments ?? true ? AppColors.background : AppColors.text,
            image: AppImages.comments,
          ),
        ),
        style: commentsState.currentState?.needShowComments ?? true ? activeAppButtonStyle : appButtonStyle,
      ),
    );
  }

  late var divider = Container(
    color: AppColors.highlight,
    width: 2,
    height: 16,
  );

  late var makeStepBtn = Tooltip(
    waitDuration: const Duration(milliseconds: 500),
    message: "Сделать шаг",
    child: ElevatedButton(
      onPressed: () {
        setState(() {
          widget.onMakeStep();
        });
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
  );

  timerBtn() {
    return Tooltip(
      waitDuration: const Duration(milliseconds: 500),
      message: "Запустить/Остановить машину",
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            widget.onStartStopWork(timesPerSec);
          });
        },
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: Image(
            color: machine.activator.isActive ? AppColors.background : AppColors.text,
            image: AppImages.timer,
          ),
        ),
        style: machine.activator.isActive ? activeAppButtonStyle : appButtonStyle,
      ),
    );
  }

  late var debugBtn = Tooltip(
    waitDuration: const Duration(milliseconds: 500),
    message: "Debug",
    child: ElevatedButton(
      onPressed: () {
        developer.log(machine.model.info());
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
  );

  late var stopBtn = Tooltip(
    waitDuration: const Duration(milliseconds: 500),
    message: "Сбросить работу машины",
    child: ElevatedButton(
      onPressed: () {
        widget.onResetWork();
        setState(() {
          
        });
      },
      child: const SizedBox(
        width: iconSize,
        height: iconSize,
        child: Image(
          image: AppImages.stop,
        ),
      ),
      style: appButtonStyle,
    ),
  );

  late var speedBtn = PopupMenuButton<int>(
    elevation: 24,
    enableFeedback: true,
    tooltip: "Скорость работы машины",
    initialValue: 1,
    onSelected: (value) {
      timesPerSec = pow(2, value-1).toInt();
      widget.onNewSpeed(timesPerSec);
    },
    shape: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(width: 1, color: AppColors.highlight)),
    child: SizedBox(
      width: iconSize,
      height: iconSize,
      child: Center(
        child: Text(
          "2x",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: AppColors.text,
          ),
        ),
      ),
    ),
    itemBuilder: (context) {
      return [
        for (int i = 0; i <= 3; i++)
          PopupMenuItem<int>(
            value: i+1,
            onTap: () {
            },
            height: 36,
            child: Text(
              "${pow(2,i)}x",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: AppColors.text,
              ),
            ),
          )
      ];
    },
  );

  late GlobalKey<BottomSplitPanelState> commentsState;

  @override
  Widget build(BuildContext context) {
    machine = MachineInherit.of(context)!.machine;
    commentsState = MachineInherit.of(context)!.bottomSplitState;
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
            children: machine.isWorking()
                ? [
                    addStateBtn,
                    spacer,
                    deleteStateBtn,
                    spacer,
                    divider,
                    spacer,
                    addRuleBtn,
                    spacer,
                    deleteRuleBtn,
                    spacer,
                    Expanded(
                      child: Container(
                        width: double.infinity,
                      ),
                    ),
                    divider,
                    spacer,
                    stopBtn,
                    spacer,
                    debugBtn,
                    spacer,
                    speedBtn,
                    spacer,
                    timerBtn(),
                    spacer,
                    makeStepBtn,
                    spacer,
                    divider,
                    spacer,
                    commentsBtn(),
                  ]
                : [
                    addStateBtn,
                    spacer,
                    deleteStateBtn,
                    spacer,
                    divider,
                    spacer,
                    addRuleBtn,
                    spacer,
                    deleteRuleBtn,
                    spacer,
                    Expanded(
                      child: Container(
                        width: double.infinity,
                      ),
                    ),
                    debugBtn,
                    spacer,
                    speedBtn,
                    spacer,
                    timerBtn(),
                    spacer,
                    makeStepBtn,
                    spacer,
                    divider,
                    spacer,
                    commentsBtn(),
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
