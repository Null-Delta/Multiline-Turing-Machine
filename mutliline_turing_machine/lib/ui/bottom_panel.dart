import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import 'package:mutliline_turing_machine/ui/bottom_split_panel.dart';
import 'package:mutliline_turing_machine/ui/configuration_counter.dart';
import 'package:mutliline_turing_machine/ui/custom_popup.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:provider/provider.dart';

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
      required this.textToUpdate,
      required this.onCommentsShow})
      : super(key: key);
  PlutoGridStateManager? tableManager;
  void Function() onAddVariant;
  void Function() onDeleteVariant;
  void Function() onAddState;
  void Function() onDeleteState;
  void Function(BuildContext) onMakeStep;
  void Function() onResetWork;
  void Function(int timesPerSec, BuildContext) onStartStopWork;
  void Function(int timesPerSec, BuildContext) onNewSpeed;
  void Function() onCommentsShow;
  GlobalKey textToUpdate;
  final FocusNode topFocus = FocusNode();

  @override
  State<BottomPanel> createState() => BottomPanelState();
}

class BottomPanelState extends State<BottomPanel> {
  late TuringMachine machine;

  static const double iconSize = 28;

  int timesPerSec = 1;
  late var scafoldState;

  Tooltip addStateBtn() => Tooltip(
        waitDuration: const Duration(milliseconds: 500),
        message: "Добавить состояние в конец (Crtl+Shift+'+')",
        child: ElevatedButton(
          focusNode: widget.topFocus,
          onPressed: () {
            widget.onAddState();
          },
          child: SizedBox(
            width: iconSize,
            height: iconSize,
            child: Image(
                image: AppImages.addState, color: Theme.of(context).cardColor),
          ),
          style: appButtonStyle(context),
        ),
      );

  Tooltip deleteStateBtn() => Tooltip(
        waitDuration: const Duration(milliseconds: 500),
        message: "Удалить выбранное состояние (Crtl+Shift+'-')",
        child: ElevatedButton(
          onPressed: () {
            widget.onDeleteState();
          },
          child: Image(
              image: AppImages.deleteState, color: Theme.of(context).cardColor),
          style: appButtonStyle(context),
        ),
      );

  Tooltip addRuleBtn() => Tooltip(
        waitDuration: const Duration(milliseconds: 500),
        message: "Добавить команду (Crtl+'+')",
        child: ElevatedButton(
          onPressed: () {
            widget.onAddVariant();
          },
          child: Image(
              image: AppImages.addVariantDown,
              color: Theme.of(context).cardColor),
          style: appButtonStyle(context),
        ),
      );

  Tooltip deleteRuleBtn() => Tooltip(
        waitDuration: const Duration(milliseconds: 500),
        message: "Удалить команду (Crtl+'+')",
        child: ElevatedButton(
          onPressed: () {
            widget.onDeleteVariant();
          },
          child: Image(
              image: AppImages.deleteVariant,
              color: Theme.of(context).cardColor),
          style: appButtonStyle(context),
        ),
      );

  late var spacer = const SizedBox(
    width: 6,
  );

  divider() => Container(
        color: Theme.of(context).highlightColor,
        width: 2,
        height: 16,
      );

  Tooltip stopBtn() => Tooltip(
        waitDuration: const Duration(milliseconds: 500),
        message: "Сбросить работу (Crtl+E)",
        child: ElevatedButton(
          onPressed: () {
            widget.onResetWork();
            setState(() {});
          },
          child: SizedBox(
            width: iconSize,
            height: iconSize,
            child: Image(
                image: AppImages.stop, color: Theme.of(context).cardColor),
          ),
          style: appButtonStyle(context),
        ),
      );

  timerBtn() {
    return Tooltip(
      waitDuration: const Duration(milliseconds: 500),
      message: "Автоматическая работа (Crtl+R)",
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            widget.onStartStopWork(timesPerSec, context);
          });
        },
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: Image(
            color: machine.activator.isActive
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).cardColor,
            image: AppImages.timer,
          ),
        ),
        style: machine.activator.isActive
            ? activeAppButtonStyle(context)
            : appButtonStyle(context),
      ),
    );
  }

  speedBtn() {
    return CustomPopup(
      tooltip: 'Скорость работы (Crtl+T)',
      onSelected: (value) {
        setState(() {
          timesPerSec = pow(2, value - 1).toInt();
          widget.onNewSpeed(timesPerSec, scafoldState);
        });
      },
      initValue: log(timesPerSec) ~/ log(2) + 1,
      itemBuilder: (context) {
        return [
          for (int i = 0; i <= 4; i++)
            PopupMenuItem<int>(
              value: i + 1,
              onTap: () {},
              height: 32,
              child: Text(
                "${pow(2, i)}x",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: Theme.of(context).cardColor,
                ),
              ),
            )
        ];
      },
      child: SizedBox(
        width: iconSize,
        height: iconSize,
        child: Center(
          child: Text(
            "${timesPerSec}x",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: Theme.of(context).cardColor,
            ),
          ),
        ),
      ),
    );
  }

  Tooltip makeStepBtn() {
    return Tooltip(
      waitDuration: const Duration(milliseconds: 500),
      message: "Сделать шаг (Crtl+Space)",
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            widget.onMakeStep(scafoldState);
          });
        },
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child:
              Image(image: AppImages.step, color: Theme.of(context).cardColor),
        ),
        style: appButtonStyle(context),
      ),
    );
  }

  commentsBtn() {
    return Tooltip(
      waitDuration: const Duration(milliseconds: 500),
      message: "Скрыть комментарии (Crtl+H)",
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
            color: commentsState.currentState?.needShowComments ?? true
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).cardColor,
            image: AppImages.comments,
          ),
        ),
        style: commentsState.currentState?.needShowComments ?? true
            ? activeAppButtonStyle(context)
            : appButtonStyle(context),
      ),
    );
  }

  late GlobalKey<BottomSplitPanelState> commentsState;

  void loadDownHotKeys() {
    //комментарии
    hotKeyManager.register(
      HotKey(
        KeyCode.keyH,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        setState(() {
          widget.onCommentsShow();
        });
      },
    );

    //авто/стоп
    hotKeyManager.register(
      HotKey(
        KeyCode.keyR,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        setState(() {
          widget.onStartStopWork(timesPerSec, context);
        });
      },
    );

    //сбросить
    hotKeyManager.register(
      HotKey(
        KeyCode.keyE,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        widget.onResetWork();
        setState(() {});
      },
    );

    //повысить скорость
    hotKeyManager.register(
      HotKey(
        KeyCode.keyT,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        setState(() {
          timesPerSec = (timesPerSec * 2).toInt();
          if (timesPerSec > 16) {
            timesPerSec = 1;
          }
          widget.onNewSpeed(timesPerSec, scafoldState);
        });
      },
    );

    //сделать шаг
    hotKeyManager.register(
      HotKey(
        KeyCode.space,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        setState(() {
          widget.onMakeStep(scafoldState);
        });
      },
    );

    //добавить состояние
    hotKeyManager.register(
      HotKey(
        KeyCode.equal,
        modifiers: [KeyModifier.control, KeyModifier.shift],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        widget.onAddState();
      },
    );

    //удалить состояние
    hotKeyManager.register(
      HotKey(
        KeyCode.minus,
        modifiers: [KeyModifier.control, KeyModifier.shift],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        widget.onDeleteState();
      },
    );

    //добавить команду
    hotKeyManager.register(
      HotKey(
        KeyCode.equal,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        widget.onAddVariant();
      },
    );

    //удалить команду
    hotKeyManager.register(
      HotKey(
        KeyCode.minus,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        widget.onDeleteVariant();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    scafoldState = context;
    machine = MachineInherit.of(context)!.machine;
    commentsState = MachineInherit.of(context)!.bottomSplitState;

    loadDownHotKeys();

    //commentsState.currentState!.comm
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 6,
            right: 6,
          ),
          height: 40,
          color: Theme.of(context).colorScheme.background,
          child: Row(
            children: machine.isWorking()
                ? [
                    addStateBtn(),
                    spacer,
                    deleteStateBtn(),
                    spacer,
                    divider(),
                    spacer,
                    addRuleBtn(),
                    spacer,
                    deleteRuleBtn(),
                    spacer,
                    Expanded(
                      child: Container(
                        width: double.infinity,
                      ),
                    ),
                    ChangeNotifierProvider.value(
                      value: machine.activator.configurationSet,
                      child: const ConfigurationCounter(),
                    ),
                    spacer,
                    divider(),
                    spacer,
                    stopBtn(),
                    spacer,
                    // debugBtn,
                    // spacer,
                    timerBtn(),
                    spacer,
                    speedBtn(),
                    spacer,
                    makeStepBtn(),
                    spacer,
                    divider(),
                    spacer,
                    commentsBtn(),
                  ]
                : [
                    addStateBtn(),
                    spacer,
                    deleteStateBtn(),
                    spacer,
                    divider(),
                    spacer,
                    addRuleBtn(),
                    spacer,
                    deleteRuleBtn(),
                    spacer,
                    Expanded(
                      child: Container(
                        width: double.infinity,
                      ),
                    ),
                    // debugBtn,
                    // spacer,
                    timerBtn(),
                    spacer,
                    speedBtn(),
                    spacer,
                    makeStepBtn(),
                    spacer,
                    divider(),
                    spacer,
                    commentsBtn(),
                  ],
          ),
        ),
        Divider(
          height: 2,
          thickness: 2,
          color: Theme.of(context).highlightColor,
        ),
      ],
    );
  }
}
