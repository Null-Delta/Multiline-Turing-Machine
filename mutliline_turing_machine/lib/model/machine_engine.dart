import 'dart:async';
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

  //запускает автоматическую работу с заданной скоростью
  String startMachine(int speed, Function() onScroll) {
    if (speed == 0) {
      return "Нулевая скорость.";
    }

    stepCount = 0;
    _passedConfigurations.clear();
    active = true;

    timer = Timer.periodic(
      Duration(milliseconds: 3000 ~/ speed),
      (timer) {
        _passedConfigurations.add(Configuration(
            Configuration.convertConfigurations(
                machine.configuration.lineContent),
            machine.configuration.linePointer));
        machine.makeStep();
        onScroll();
        stepCount++;
      },
    );
    return "";
  }

  // останавливает работу, приводя машину в начальное состояние, но при этом сохраняя количество конфигураций и шагов.
  void stopMachine() {
    active = false;
    _passedConfigurations.add(Configuration(
        Configuration.convertConfigurations(machine.configuration.lineContent),
        machine.configuration.linePointer));
    machine.configuration.currentStateIndex = 0;
    machine.configuration.currentVatiantIndex = -1;
    machine.configuration.activeState.activeStateIndex = -1;
    machine.configuration.activeState.activeVariantIndex = -1;
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
  }

  MachineEngine(this.machine);
}
