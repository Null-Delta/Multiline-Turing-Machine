import 'dart:developer';
import 'package:mutliline_turing_machine/model/line_cell_model.dart';
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


  //NOT TESTED
  TuringMachine.fromJsonElements(
      {required List<int> linePointers,
      required List<List<String>> lineContent,
      required String description,
      required List<List<List<dynamic>>> stateList}) {
    configuration.linePointers = linePointers;

    configuration.lineContent = List.generate(
      lineContent.length,
      (i) => List.generate(
        lineContent[i].length,
        (j) => LineCellModel(symbol: lineContent[i][j]),
      ),
    );

    model.description = description;

    model.stateList = List.generate(
      stateList.length,
      (i) => TuringMachineState.fromRuleList(
        List.generate(
          stateList[i].length,
          (j) => TuringMachineVariant.fromCommandListAndToState(
              List.generate(
                  (stateList[i][j][0] as List<String>).length,
                  (k) => TuringCommand.parse(
                      (stateList[i][j][0] as List<String>)[k])!),
              stateList[i][j][1] as int),
        ),
      ),
    );
  }


  Map<String, dynamic> toJson() => {
        'linePointers': configuration.linePointers,
        'lineContent': List.generate(
            configuration.lineContent.length,
            (i) => List.generate(
                2001, (j) => configuration.lineContent[i][j].symbol)),
        'description': model.description,
        'stateList': List.generate(
          model.stateList.length,
          (i) => List.generate(
              model.stateList[i].ruleList.length,
              (j) => [
                    List.generate(
                        model.stateList[i].ruleList[j].commandList.length,
                        (k) => model.stateList[i].ruleList[j].commandList[k]
                            .toString()),
                    model.stateList[i].ruleList[j].toState
                  ]),
        ),
      };


  //NOT TESTED
  factory TuringMachine.fromJson(Map<String, dynamic> json) {
    return TuringMachine.fromJsonElements(
      linePointers: json['linePointers'] as List<int>,
      lineContent: json['lineContent'] as List<List<String>>,
      description: json['description'] as String,
      stateList: json['stateList'] as List<List<List<dynamic>>>,
    );
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
        variantIndex < currentState.ruleList.length;
        variantIndex++) {
      var currentVariant = currentState.ruleList[variantIndex];
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
        variantIndex < currentState.ruleList.length;
        variantIndex++) {
      bool isSuitable = true;
      var currentVariant = currentState.ruleList[variantIndex];

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

        findCurrentState();
        return "";
      }
    }
    configuration.currentVatiantIndex = -1;
    if (activator.isActive) {
      activator.stopMachine();
    }
    return "Не найден текущий вариант.";
  }
}
