import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'turing_machine_model.dart';

class SetOfConfigurations {
  SetOfConfigurations? _lChild;
  SetOfConfigurations? _rChild;
  List<String>? _lines;
  List<int>? _pointers;
  int _countOfLines = 0;
  int get count => _countOfLines;

  SetOfConfigurations();
  SetOfConfigurations._inClass(List<String> l,List<int> p){
    _countOfLines = 1;
    _lines = l.toList();
    _pointers = p.toList();
  }

  void clear(){
    _lChild = null;
    _rChild = null;
    _lines = null;
    _pointers = null;
    _countOfLines = 0;
  }

  int add(List<String> l, List<int> p){
    if (_lines == null){
      _lines = l.toList();
      _pointers = p.toList();
      _countOfLines = 1;
      return 1;
    }
    else {
      bool isBigger = true;
      bool same = true;
      for (int i = 0; i < l.length; i++){
        if (!isBigger) {
          break;
        }
        same = l[i] == _lines![i] && same;
        isBigger = l[i].compareTo(_lines![i]) >=0;
      }
      for (int i = 0; i < p.length; i++){
        if (!isBigger) {
          break;
        }
        same = p[i] == _pointers![i] && same;
        isBigger = p[i] >= _pointers![i];
      }
      if (isBigger && !same){
        if (_rChild == null) {
          _rChild = SetOfConfigurations._inClass(l, p);
          _countOfLines++;
          return 1;
        } else {
          if (_rChild!.add(l, p) == 1){
            _countOfLines++;
            return 1;
          }
        }
      } else if (!isBigger) {
        if (_lChild == null) {
          _lChild = SetOfConfigurations._inClass(l, p);
          _countOfLines++;
          return 1;
        } else {
          if (_lChild!.add(l, p) == 1){
            _countOfLines++;
            return 1;
          }
        }
      }
    }
    return 0;
  }

  static List<String> convertConfigurations(List<List<LineCellModel>> lineContent){
    List<String> lines = [];
    for (int i = 0; i < lineContent.length; i++){
      String tmpS = "";
      for (int j = 0; j < lineContent[i].length; j++){
        tmpS += lineContent[i][j].symbol == "" ? "_" : lineContent[i][j].symbol;
      }
      lines.add(tmpS);
    }
    return lines;
  }
}

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

  //множество конфигураций, пройденные машиной
  late SetOfConfigurations passedConfigurations = SetOfConfigurations();

  ActiveState activeState = ActiveState();

  TuringMachineState get currentState => model.stateList[currentStateIndex];

  //закоментил, ибо, нигде не используется bool get isWorking => currentStateIndex != 1;

  //обект-таймер
  Timer? timer;

  // запущена ли машина
  late bool active = false;

  bool get isActive => active;

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

    for(int i = 0; i < linePointer.length; i++)
    {
      lineContent[i][linePointer[i]].setActive(true);
    }

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

  //ставит символ на ленту и смещает указатель вправо
  void setSymbol(int lineIndex, String symbol) {
    var inputSymbol = symbol == "_" || symbol == "*" ? " " : symbol;
    lineContent[lineIndex][linePointer[lineIndex]].setSymbol(inputSymbol);

    //moveLine(lineIndex, 1);
  }

  void setActive(int lineIndex, bool isActive) {
    lineContent[lineIndex][linePointer[lineIndex]].setActive(isActive);
  }

  void setFocus(int lineIndex) {
    focusedLine = lineIndex;
    for(int i = 0; i < linePointer.length; i++)
    {
      lineContent[i][linePointer[i]].setFocus(false);
    }
    lineContent[lineIndex][linePointer[lineIndex]].setFocus(true);
  } 

  //очищает текуший символ ленты и сдвигает указатель влево
  void clearSymbol(int lineIndex) {
    var contentIndex = linePointer[lineIndex];
    lineContent[lineIndex][contentIndex].setSymbol(" ");
    moveLine(lineIndex, -1);
  }

  //сдвигает головку ленты и делает ячейку под ней активной
  void moveLine(int lineIndex, int offset) {

    if(lineIndex == focusedLine) {
      lineContent[focusedLine][linePointer[focusedLine]].setFocus(false);
      lineContent[focusedLine][linePointer[focusedLine] + offset].setFocus(true);
    }

    setActive(lineIndex, false);
    linePointer[lineIndex] += offset;
    setActive(lineIndex, true);
    
    
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
          stopMachine();
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
          stopMachine();
        }
        activeState.activeStateIndex = currentStateIndex;
        log(info());
        return "";
      }
    }
    currentVatiantIndex = -1;
    stopMachine();
    return "Не найден текущий вариант.";
  }

  String startMachine(int speed)
  {
    if (speed == 0) {
      return "Нулевая скорость.";
    }
    
    passedConfigurations.clear();
    active = true;
    timer = Timer.periodic(
      Duration(milliseconds: 3000~/speed),
      (timer) {
        passedConfigurations.add(SetOfConfigurations.convertConfigurations(lineContent), linePointer);
        makeStep();
      },
    );
    return "";
  }

  String stopMachine()
  {
    passedConfigurations.add(SetOfConfigurations.convertConfigurations(lineContent), linePointer);
    active = false;
    currentStateIndex = 0;
    currentVatiantIndex = -1;
    activeState.activeStateIndex = -1;
    activeState.activeVariantIndex = -1;
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    return "";
  }

/*
  void stopMachine() {
    currentStateIndex = 0;
    currentVatiantIndex = -1;
    activeState.activeStateIndex = -1;
    activeState.activeVariantIndex = -1;
  }
*/

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
