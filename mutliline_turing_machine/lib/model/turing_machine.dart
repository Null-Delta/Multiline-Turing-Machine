import 'dart:async';
import 'dart:developer';

import 'turing_machine_model.dart';

class Configuration {
  List<String> lines = [];
  List<int> pointers = [];
  int get countOfLines => lines.length;
  Configuration(this.lines, this.pointers);
}

class ActiveState {
  int activeStateIndex = -1;
  int activeVariantIndex = -1;
}

class TuringMachine {
  //модель машины тьюринга
  late TuringMachineModel model;

  //содержимое лент
  late List<String> lineContent;

  //индексы указателей на активные ячейки лент
  late List<int> linePointer;

  //текущее активное состояние
  late int currentStateIndex;

  //текущий обрабатываемый вариант
  late int currentVatiantIndex;

  //множество конфигураций, пройденные машиной
  late Set<Configuration> passedConfigurations;

  //обект-таймер
  late Timer timer;

  // запущена ли машина
  late bool active = false;

  ActiveState activeState = ActiveState();

  TuringMachineState get currentState => model.stateList[currentStateIndex];

  bool get IsActive => active;

  //закомитил, ибо не нашёл ссылок bool get isWorking => currentStateIndex != 1;

  

  TuringMachine(TuringMachineModel m) {
    model = m;
    lineContent = [for (int i = 0; i < model.countOfLines; i++) " " * 2001];
    linePointer = [for (int i = 0; i < model.countOfLines; i++) 1000];
    currentStateIndex = 0;
    currentVatiantIndex = -1;
  }

  void clearLine(lineIndex) {
    lineContent[lineIndex] = " " * 2001;
    linePointer[lineIndex] = 1000;
  }

  void addLine() {
    lineContent.add(" " * 2001);
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
    return lineContent[lineIndex][linePointer[lineIndex]];
  }

  bool checkSymbol(String symbol, String predicate) =>
      predicate == "*" ||
      symbol == predicate ||
      (predicate == "_" && symbol == " ");

  //ставит символ на ленту и смещает указатель вправо
  void setSymbol(int lineIndex, String symbol) {
    var inputSymbol = symbol == "_" ? " " : symbol;
    lineContent[lineIndex] = replaceCharAt(
        lineContent[lineIndex], linePointer[lineIndex], inputSymbol);
    //moveLine(lineIndex, 1);
  }

  //очищает текуший символ ленты и сдвигает указатель влево
  void clearSymbol(int lineIndex) {
    var contentIndex = linePointer[lineIndex];
    lineContent[lineIndex] =
        replaceCharAt(lineContent[lineIndex], contentIndex, " ");
    moveLine(lineIndex, -1);
  }

  String replaceCharAt(String oldString, int index, String newChar) {
    return oldString.substring(0, index) +
        newChar +
        oldString.substring(index + 1);
  }

  //сдвигает головку ленты
  void moveLine(int lineIndex, int offset) {
    linePointer[lineIndex] += offset;
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
        activeState.activeStateIndex = currentStateIndex;
        log(info());
        return "";
      }
    }
    currentVatiantIndex = -1;
    return "Не найден текущий вариант.";
  }

  String startWork(int speed)
  {
    if (speed == 0) {
      return "Нулевая скорость.";
    }
    
    passedConfigurations.clear();
    passedConfigurations.add(Configuration(lineContent, linePointer));
    active = true;
    timer = Timer.periodic(
      Duration(milliseconds: 3000~/speed),
      (timer) {
        log("1");///////////////////////////
        passedConfigurations.add(Configuration(lineContent, linePointer));
        if (makeStep() != "")
        {
          active = false;
          timer.cancel();
        }
      },
    );
    return "";
  }

  String stopWork()
  {
    active = false;
    timer.cancel();
    return "";
  }


  void stopMachine() {
    currentStateIndex = 0;
    currentVatiantIndex = -1;
    activeState.activeStateIndex = -1;
    activeState.activeVariantIndex = -1;
  }

  String info() {
    var result = "";
    for (int lineIndex = 0; lineIndex < model.countOfLines; lineIndex++) {
      result += lineContent[lineIndex]
          .substring(linePointer[lineIndex] - 8, linePointer[lineIndex] - 1);
      result += "|${lineContent[lineIndex][linePointer[lineIndex]]}|";
      result += lineContent[lineIndex]
          .substring(linePointer[lineIndex] + 1, linePointer[lineIndex] + 8);
      result += "\n";
    }
    result += "\n";
    return result;
  }
}
