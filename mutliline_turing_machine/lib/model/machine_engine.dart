import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'configurations.dart';

class ConfigurationSet extends ChangeNotifier {
  final Set<Configuration> _passedConfigurations = {};
  int get countConfigurations => _passedConfigurations.length;

  int get length => _passedConfigurations.length;

  void clear() {
    _passedConfigurations.clear();
    notifyListeners();
  }

  void add(Configuration conf) {
    _passedConfigurations.add(conf);
    notifyListeners();
  }
}

// класс, отвечающий за автоматическую работу машины
class MachineEngine {
  late TuringMachine machine;

  //множество конфигураций, пройденные машиной
  ConfigurationSet configurationSet = ConfigurationSet();
  //количество шагов данного запуска
  late int stepCount;

  //обект-таймер
  Timer? timer;

  // запущена ли машина
  late bool active = false;
  late bool isHasConfiguration = configurationSet.length != 0;
  bool get isActive => active;
  int timesPerSecond = 1;

  //запускает автоматическую работу с заданной скоростью
  bool startMachine(
      int timesPerSecond, Function() onScroll, GlobalKey textCounter) {
    if (timesPerSecond <= 0 || timesPerSecond > 32) {
      return false;
    }

    this.timesPerSecond = timesPerSecond;
    active = true;

    timer = Timer.periodic(
      Duration(milliseconds: 1000 ~/ timesPerSecond),
      (timer) {
        onScroll();
        stepCount++;
      },
    );
    return true;
  }

  // останавливает работу, сохраняя состояние
  void setNewSpeed(int timesPerSecond, Function() onScroll) {
    this.timesPerSecond = timesPerSecond;
    if (active) {
      timer!.cancel();
      timer = Timer.periodic(
        Duration(milliseconds: 1000 ~/ timesPerSecond),
        (timer) {
          onScroll();
          stepCount++;
          configurationSet.add(Configuration(
              Configuration.convertConfigurations(
                  machine.configuration.lineContent),
              machine.configuration.linePointers));
        },
      );
    }
  }

  // останавливает работу, сохраняя состояние
  void stopMachine() {
    active = false;
    configurationSet.add(Configuration(
        Configuration.convertConfigurations(machine.configuration.lineContent),
        machine.configuration.linePointers));
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
