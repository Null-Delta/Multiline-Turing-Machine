import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'configurations.dart';

// класс, отвечающий за автоматическую работу машины
class MachineEngine {
  late TuringMachine machine;

  //множество конфигураций, пройденные машиной
  Set<Configuration> _passedConfigurations = {};

  int get countConfigurations => _passedConfigurations.length;

  //количество шагов данного запуска
  late int stepCount;

  //обект-таймер
  Timer? timer;

  // запущена ли машина
  late bool active = false;
  bool get isActive => active;
  int timesPerSecond = 1;

  //запускает автоматическую работу с заданной скоростью
  bool startMachine(int timesPerSecond, Function() onScroll, GlobalKey textCounter) {
    if (timesPerSecond <= 0 || timesPerSecond > 32) {
      return false;
    }

    stepCount = 0;
    _passedConfigurations.clear();
    _passedConfigurations.add(Configuration(Configuration.convertConfigurations(machine.configuration.lineContent),
            machine.configuration.linePointers));
    active = true;

    timer = Timer.periodic(
      Duration(milliseconds: 1000 ~/ timesPerSecond),
      (timer) {
        machine.makeStep();
        onScroll();
        stepCount++;
        _passedConfigurations.add(Configuration(Configuration.convertConfigurations(machine.configuration.lineContent),
            machine.configuration.linePointers));
        textCounter.currentState!.setState(() {
          
        });
      },
    );
    return true;
  }

  // останавливает работу, сохраняя состояние
  void setNewSpeed(int timesPerSecond, Function() onScroll) {
    if (active)
    {
      timer!.cancel();
      timer = Timer.periodic(
        Duration(milliseconds: 1000 ~/ timesPerSecond),
        (timer) {
          machine.makeStep();
          onScroll();
          stepCount++;
          _passedConfigurations.add(Configuration(Configuration.convertConfigurations(machine.configuration.lineContent),
              machine.configuration.linePointers));
        },
      );
    }
  }

  // останавливает работу, сохраняя состояние
  void stopMachine() {
    active = false;
    _passedConfigurations.add(Configuration(
        Configuration.convertConfigurations(machine.configuration.lineContent), machine.configuration.linePointers));
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }

  // останавливает работу, приводит машину к начальному состоянию
  void resetMachine() {
    stopMachine();
    machine.configuration.currentStateIndex = 0;
    machine.configuration.currentVatiantIndex = -1;
    machine.configuration.activeState.activeStateIndex = -1;
    machine.configuration.activeState.activeVariantIndex = -1;
  }

  MachineEngine(this.machine);
}
