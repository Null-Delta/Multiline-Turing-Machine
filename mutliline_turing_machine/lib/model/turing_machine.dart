import 'package:mutliline_turing_machine/model/line_cell_model.dart';
import 'package:mutliline_turing_machine/model/machine_engine.dart';
import 'configurations.dart';
import 'turing_machine_configuration.dart';
import 'turing_machine_model.dart';

import 'dart:convert';

//класс отвечающий за состояние машины во время работы
class ActiveState {
  int activeStateIndex = -1;
  int activeVariantIndex = -1;
}

class TuringMachine {
  //модель машины тьюринга
  late TuringMachineModel model;
  late TuringMachineConfiguration configuration;
  late String? filePath;

  String? saveMachineJson;
  String? saveLinesJson;

  TuringMachineState get currentState =>
      model.stateList[configuration.currentStateIndex];
  TuringMachineState get activeState =>
      model.stateList[configuration.activeState.activeStateIndex];

  bool isWorking() =>
      configuration.activeState.activeStateIndex != -1 || activator.active;

  // класс, отвечающий за автоматическую работу машины
  late MachineEngine activator;

  TuringMachine(TuringMachineModel m) {
    model = m;
    filePath = null;
    configuration = TuringMachineConfiguration(model.countOfLines);
    activator = MachineEngine(this);
  }

  loadFromJson(Map<String, dynamic> json) {
    loadFromJsonElements(
      linePointers: json['linePointers'],
      lineContent: json['lineContent'],
      description: json['description'],
      stateList: json['stateList'],
    );
  }

  void loadFromJsonElements(
      {required List<dynamic> linePointers,
      required List<dynamic> lineContent,
      required String description,
      required List<dynamic> stateList}) {
    configuration = TuringMachineConfiguration(linePointers.length);

    configuration.linePointers =
        List.generate(linePointers.length, (i) => linePointers[i]);

    configuration.lineContent = List.generate(
      lineContent.length,
      (i) => List.generate(
        lineContent[i].length,
        (j) => LineCellModel(symbol: lineContent[i][j]),
      ),
    );

    for (int i = 0; i < configuration.linePointers.length; i++) {
      configuration.lineContent[i][linePointers[i]].setActive(true);
    }

    model = TuringMachineModel();

    model.description = description;
    model.countOfLines = lineContent.length;
    model.stateList = List.generate(
      stateList.length,
      (i) => TuringMachineState.fromRuleList(
        List.generate(
          stateList[i].length,
          (j) => TuringMachineVariant.fromCommandListAndToState(
              List.generate((stateList[i][j][0]).length,
                  (k) => TuringCommand.parse((stateList[i][j][0])[k])!),
              stateList[i][j][1] as int),
        ),
      ),
    );

    activator = MachineEngine(this);
  }

  //NOT TESTED
  TuringMachine.fromJsonElements(
      {required List<dynamic> linePointers,
      required List<dynamic> lineContent,
      required String description,
      required List<dynamic> stateList}) {
    configuration = TuringMachineConfiguration(linePointers.length);

    configuration.linePointers =
        List.generate(linePointers.length, (i) => linePointers[i]);

    configuration.lineContent = List.generate(
      lineContent.length,
      (i) => List.generate(
        lineContent[i].length,
        (j) => LineCellModel(symbol: lineContent[i][j]),
      ),
    );

    for (int i = 0; i < configuration.linePointers.length; i++) {
      configuration.lineContent[i][linePointers[i]].setActive(true);
    }

    model = TuringMachineModel();

    model.description = description;
    model.countOfLines = lineContent.length;
    model.stateList = List.generate(
      stateList.length,
      (i) => TuringMachineState.fromRuleList(
        List.generate(
          stateList[i].length,
          (j) => TuringMachineVariant.fromCommandListAndToState(
              List.generate((stateList[i][j][0]).length,
                  (k) => TuringCommand.parse((stateList[i][j][0])[k])!),
              stateList[i][j][1] as int),
        ),
      ),
    );

    activator = MachineEngine(this);
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

  Map<String, dynamic> linesToJson() => {
        'linePointers': configuration.linePointers,
        'lineContent': List.generate(
            configuration.lineContent.length,
            (i) => List.generate(
                2001, (j) => configuration.lineContent[i][j].symbol)),
      };

  void importLinesJson(String json) {
    var map = jsonDecode(json);
    List<dynamic> linePointers = map['linePointers'];
    List<dynamic> lineContent = map['lineContent'];

    configuration = TuringMachineConfiguration(linePointers.length);

    configuration.linePointers =
        List.generate(linePointers.length, (i) => linePointers[i]);

    configuration.lineContent = List.generate(
      lineContent.length,
      (i) => List.generate(
        lineContent[i].length,
        (j) => LineCellModel(symbol: lineContent[i][j]),
      ),
    );

    for (int i = 0; i < configuration.linePointers.length; i++) {
      configuration.lineContent[i][linePointers[i]].setActive(true);
    }

    var count = model.countOfLines;
    if (count != configuration.linePointers.length) {
      for (int i = 0;
          i < (count - configuration.linePointers.length).abs();
          i++) {
        count < configuration.linePointers.length
            ? {model.addLine()}
            : {model.deleteLine()};
      }
    }
  }

  //NOT TESTED
  factory TuringMachine.fromJson(Map<String, dynamic> json) {
    return TuringMachine.fromJsonElements(
      linePointers: json['linePointers'],
      lineContent: json['lineContent'],
      description: json['description'],
      stateList: json['stateList'],
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
        variantIndex < activeState.ruleList.length;
        variantIndex++) {
      var currentVariant = activeState.ruleList[variantIndex];
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
      activator.stepCount = 0;
      activator.configurationSet.clear();
      activator.configurationSet.add(Configuration(
          Configuration.convertConfigurations(configuration.lineContent),
          configuration.linePointers));
      configuration.currentStateIndex = 0;
      configuration.activeState.activeStateIndex = 0;
    }

    for (int variantIndex = 0;
        variantIndex < activeState.ruleList.length;
        variantIndex++) {
      bool isSuitable = true;
      var currentVariant = activeState.ruleList[variantIndex];

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
          return "Состояние ${currentVariant.toState + 1} не найдено.";
        }
        var canMove = true;

        for (int lineIndex = 0; lineIndex < model.countOfLines; lineIndex++) {
          var currentCommand = currentVariant.commandList[lineIndex];
          configuration.setSymbol(lineIndex, currentCommand.output);
          switch (currentCommand.moveType) {
            case "<":
              if (!canMove) {
                configuration.moveLine(lineIndex, -1);
              } else {
                canMove = configuration.moveLine(lineIndex, -1);
              }
              break;
            case ">":
              if (!canMove) {
                configuration.moveLine(lineIndex, 1);
              } else {
                canMove = configuration.moveLine(lineIndex, 1);
              }
              break;
            default:
              break;
          }
        }

        if (!canMove) {
          if (activator.isActive) {
            activator.stopMachine();
          }
          return "Вы достигли конца ленты. Перемещение головки невозможно.";
        }

        if (currentVariant.toState == -1) {
          activator.stopMachine();
          return "!";
        }
        configuration.currentStateIndex = currentVariant.toState;

        configuration.activeState.activeStateIndex =
            configuration.currentStateIndex;

        findCurrentState();
        activator.configurationSet.add(Configuration(
            Configuration.convertConfigurations(configuration.lineContent),
            configuration.linePointers));
        return "";
      }
    }
    configuration.currentVatiantIndex = -1;
    if (activator.isActive) {
      activator.stopMachine();
    }
    return "Не найдена подходящяя команда.";
  }
}
