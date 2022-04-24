import 'dart:developer';
import 'package:mutliline_turing_machine/model/machine_engine.dart';
import 'turing_machine_configuration.dart';
import 'turing_machine_model.dart';

//класс отвечающий за состояние машины во время работы
class ActiveState {
  int activeStateIndex = -1;
  int activeVariantIndex = -1;
}

class TuringMachine {
  //модель машины тьюринга
  late TuringMachineModel model;
  late TuringMachineConfiguration configuration;

  TuringMachineState get currentState =>
      model.stateList[configuration.currentStateIndex];

  // класс, отвечающий за автоматическую работу машины
  late MachineEngine activator;

  TuringMachine(TuringMachineModel m) {
    model = m;
    configuration = TuringMachineConfiguration(model.countOfLines);

    activator = MachineEngine(this);
  }

  bool addLine() {
    if (model.countOfLines >= 16) {
      return false;
    }
    configuration.addLine();
    model.addLine();
    return true;
  }

  bool deleteLine() {
    if (model.countOfLines <= 0) {
      return false;
    }
    configuration.deleteLine();
    model.deleteLine();
    return true;
  }

  bool findCurrentState() {
    for (int variantIndex = 0;
        variantIndex < currentState.variantList.length;
        variantIndex++) {
      var currentVariant = currentState.variantList[variantIndex];
      bool isSuitable = true;

      for (int lineIndex = 0; lineIndex < model.countOfLines; lineIndex++) {
        var currentCommand = currentVariant.commandList[lineIndex];
        if (!configuration.checkSymbol(
            configuration.getSymbol(lineIndex), currentCommand.input)) {
          isSuitable = false;
          break;
        }
      }

      if (isSuitable) {
        configuration.currentVatiantIndex = variantIndex;
        configuration.activeState.activeVariantIndex = variantIndex;
        return true;
      }
    }

    //configuration.currentVatiantIndex = -1;
    //configuration.activeState.activeVariantIndex = -1;

    return false;
  }

  //выполняет шаг и возвращает сообщение, информирующее о корректности
  //выполнения шага:
  //если шаг выполнен - возвращается пустая строка
  //иначе - сообщение об ошибке
  String makeStep() {
    if (configuration.activeState.activeStateIndex == -1) {
      configuration.currentStateIndex = 0;
      configuration.activeState.activeStateIndex = 0;
    }

    for (int variantIndex = 0;
        variantIndex < currentState.variantList.length;
        variantIndex++) {
      bool isSuitable = true;
      var currentVariant = currentState.variantList[variantIndex];

      for (int lineIndex = 0; lineIndex < model.countOfLines; lineIndex++) {
        var currentCommand = currentVariant.commandList[lineIndex];
        if (!configuration.checkSymbol(
            configuration.getSymbol(lineIndex), currentCommand.input)) {
          isSuitable = false;
          break;
        }
      }
      if (isSuitable) {
        configuration.currentVatiantIndex = variantIndex;
        configuration.activeState.activeVariantIndex =
            configuration.currentVatiantIndex;
        if (currentVariant.toState >= model.stateList.length) {
          if (activator.isActive) {
            activator.stopMachine();
          }
          return "Состояние ${currentVariant.toState} не найдено.";
        }
        for (int lineIndex = 0; lineIndex < model.countOfLines; lineIndex++) {
          var currentCommand = currentVariant.commandList[lineIndex];
          configuration.setSymbol(lineIndex, currentCommand.output);
          switch (currentCommand.moveType) {
            case "<":
              configuration.moveLine(lineIndex, -1);
              break;
            case ">":
              configuration.moveLine(lineIndex, 1);
              break;
            default:
              break;
          }
        }
        configuration.currentStateIndex = currentVariant.toState;
        if (currentVariant.toState == -1) {
          if (activator.isActive) {
            activator.stopMachine();
          }
        }
        configuration.activeState.activeStateIndex =
            configuration.currentStateIndex;
        //log(info());
        return "";
      }
    }
    configuration.currentVatiantIndex = -1;
    if (activator.isActive) {
      activator.stopMachine();
    }
    return "Не найден текущий вариант.";
  }

  // String info() {
  //   var result = "";
  //   for (int lineIndex = 0; lineIndex < model.countOfLines; lineIndex++) {
  //     for (int index = configuration.linePointer[lineIndex] - 8;
  //         index <= configuration.linePointer[lineIndex] + 8;
  //         index++) {
  //       result += configuration.lineContent[lineIndex][index].symbol;
  //     }
  //     result += "\n";
  //   }
  //   result += "\n";
  //   return result;
  // }
}
