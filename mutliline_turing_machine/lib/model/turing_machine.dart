import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/machine_engine.dart';
import 'configurations.dart';
import 'turing_machine_model.dart';

class LineCellModel extends ChangeNotifier {
  LineCellModel({this.symbol = " "});
  String symbol;
  bool isActive = false;
  bool isFocus = false;

  void setSymbol(String symbol) {
    this.symbol = symbol;
    notifyListeners();
  }

  void setActive(bool isActive) {
    this.isActive = isActive;
    notifyListeners();
  }

  void setFocus(bool isFocus) {
    this.isFocus = isFocus;
    notifyListeners();
  }
}

//класс отвечающий за состояние машины во время работы
class ActiveState {
  int activeStateIndex = -1;
  int activeVariantIndex = -1;
}

class TuringMachine {
  //модель машины тьюринга
  late TuringMachineModel model;

  //содержимое лент
  late List<List<LineCellModel>> lineContent;

  //индексы указателей на активные ячейки лент
  late List<int> linePointer;

  //
  late int focusedLine = -1;
  //текущее активное состояние
  late int currentStateIndex;

  //текущий обрабатываемый вариант
  late int currentVatiantIndex;

  ActiveState activeState = ActiveState();

  TuringMachineState get currentState => model.stateList[currentStateIndex];

  // класс, отвечающий за автоматическую работу машины
  late MachineEngine activator;

  TuringMachine(TuringMachineModel m) {
    model = m;
    lineContent = [];
    for (int i = 0; i < model.countOfLines; i++) {
      lineContent.add([]);
      for (int j = 0; j < 2000; j++) {
        lineContent[i].add(LineCellModel());
      }
    }
    //lineContent = [for (int i = 0; i < model.countOfLines; i++) " " * 2001];
    linePointer = [for (int i = 0; i < model.countOfLines; i++) 1000];

    for (int i = 0; i < linePointer.length; i++) {
      lineContent[i][linePointer[i]].setActive(true);
    }
    activator = MachineEngine(this);
    currentStateIndex = 0;
    currentVatiantIndex = -1;
  }

  void clearLine(lineIndex) {
    //lineContent[lineIndex] = " " * 2001;
    linePointer[lineIndex] = 1000;
  }

  void addLine() {
    //lineContent.add(" " * 2001);
    linePointer.add(1000);
    model.addLine();
  }

  void deleteLine() {
    lineContent.removeLast();
    linePointer.removeLast();
    model.deleteLine();
  }

  //Возвращает символ ленты на месте указателя
  String getSymbol(int lineIndex) {
    return lineContent[lineIndex][linePointer[lineIndex]].symbol;
  }

  bool checkSymbol(String symbol, String predicate) =>
      predicate == "*" ||
      symbol == predicate ||
      (predicate == "_" && symbol == " ");

  //ставит символ на ленту
  void setSymbol(int lineIndex, String symbol) {
    var inputSymbol = symbol == "_" || symbol == "*" ? " " : symbol;
    lineContent[lineIndex][linePointer[lineIndex]].setSymbol(inputSymbol);
  }

  //ставит символ на ленту и смещает указатель вправо
  void writeSymbol(int lineIndex, String symbol) {
    lineContent[lineIndex][linePointer[lineIndex]].setSymbol(symbol);
    moveLine(lineIndex, 1);
  }

  //очищает текуший символ ленты и сдвигает указатель влево
  void clearSymbol(int lineIndex) {
    lineContent[lineIndex][linePointer[lineIndex]].setSymbol(" ");
    moveLine(lineIndex, -1);
  }

  void setActive(int lineIndex, bool isActive) {
    lineContent[lineIndex][linePointer[lineIndex]].setActive(isActive);
  }

  void setFocus(int lineIndex, bool isFocus) {
    if (isFocus) {
      focusedLine = lineIndex;
      // for (int i = 0; i < linePointer.length; i++) {
      //   lineContent[i][linePointer[i]].setFocus(false);
      // }
      lineContent[lineIndex][linePointer[lineIndex]].setFocus(true);
    } else {
      focusedLine = -1;
      lineContent[lineIndex][linePointer[lineIndex]].setFocus(false);
    }
  }

  //сдвигает головку ленты и делает ячейку под ней активной
  void moveLine(int lineIndex, int offset) {
    if (lineIndex == focusedLine) {
      setFocus(lineIndex, false);
      setActive(lineIndex, false);
      linePointer[lineIndex] += offset;
      setFocus(lineIndex, true);
      setActive(lineIndex, true);
    } else {
      setActive(lineIndex, false);
      linePointer[lineIndex] += offset;
      setActive(lineIndex, true);
    }
  }

  //выполняет шаг и возвращает сообщение, информирующее о корректности
  //выполнения шага:
  //если шаг выполнен - возвращается пустая строка
  //иначе - сообщение об ошибке
  String makeStep() {
    for (int variantIndex = 0;
        variantIndex < currentState.variantList.length;
        variantIndex++) {
      bool isSuitable = true;
      var currentVariant = currentState.variantList[variantIndex];

      for (int lineIndex = 0; lineIndex < model.countOfLines; lineIndex++) {
        var currentCommand = currentVariant.commandList[lineIndex];
        if (!checkSymbol(getSymbol(lineIndex), currentCommand.input)) {
          isSuitable = false;
          break;
        }
      }
      if (isSuitable) {
        currentVatiantIndex = variantIndex;
        activeState.activeVariantIndex = currentVatiantIndex;
        if (currentVariant.toState >= model.stateList.length) {
          if (activator.isActive) {
            activator.stopMachine();
          }
          return "Состояние ${currentVariant.toState} не найдено.";
        }
        for (int lineIndex = 0; lineIndex < model.countOfLines; lineIndex++) {
          var currentCommand = currentVariant.commandList[lineIndex];
          setSymbol(lineIndex, currentCommand.output);
          switch (currentCommand.moveType) {
            case "<":
              moveLine(lineIndex, -1);
              break;
            case ">":
              moveLine(lineIndex, 1);
              break;
            default:
              break;
          }
        }
        currentStateIndex = currentVariant.toState;
        if (currentVariant.toState == -1){
          if (activator.isActive) {
            activator.stopMachine();
          }
        }
        activeState.activeStateIndex = currentStateIndex;
        log(info());
        return "";
      }
    }
    currentVatiantIndex = -1;
    if (activator.isActive) {
      activator.stopMachine();
    }
    return "Не найден текущий вариант.";
  }

  String info() {
    var result = "";
    for (int lineIndex = 0; lineIndex < model.countOfLines; lineIndex++) {
      for (int index = linePointer[lineIndex] - 8;
          index <= linePointer[lineIndex] + 8;
          index++) {
        result += lineContent[lineIndex][index].symbol;
      }
      result += "\n";
    }
    result += "\n";
    return result;
  }
}
