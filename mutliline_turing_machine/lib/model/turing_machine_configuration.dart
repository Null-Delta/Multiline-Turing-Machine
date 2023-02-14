import 'line_cell_model.dart';
import 'turing_machine.dart';

class TuringMachineConfiguration {
  //содержимое лент
  late List<List<LineCellModel>> lineContent;

  //индексы указателей на активные ячейки лент
  late List<int> linePointers;
  //индексы указателей на ячейки лент для ввода

  late int focusedLine = -1;
  late int focusedIndex = -1;
  //текущее активное состояние
  late int currentStateIndex;

  //текущий обрабатываемый вариант
  late int currentVatiantIndex;

  ActiveState activeState = ActiveState();

  TuringMachineConfiguration(int linesCount) {
    lineContent = List.generate(
        linesCount, (_) => List.generate(2001, (_) => LineCellModel()));

    linePointers = List.generate(linesCount, (_) => 1000);

    for (int i = 0; i < linePointers.length; i++) {
      lineContent[i][linePointers[i]].setActive(true);
    }

    currentStateIndex = 0;
    currentVatiantIndex = -1;
  }

  void clearLine(lineIndex) {
    lineContent[lineIndex] = List.generate(2001, (_) => LineCellModel());
    linePointers[lineIndex] = 1000;
  }

  void addLine() {
    linePointers.add(1000);
    lineContent.add(List.generate(2001, (_) => LineCellModel()));
    lineContent.last[linePointers.last].setActive(true);
  }

  void deleteLine() {
    lineContent.removeLast();
    linePointers.removeLast();
  }

  void setFocusLine(int lineIndex, bool isFocus) {
    if (lineIndex != focusedLine) {
      if (isFocus) {
        focusedLine = lineIndex;
        focusedIndex = linePointers[lineIndex];
        lineContent[lineIndex][focusedIndex].setFocus(true);
      }
    } else if (!isFocus) {
      if (focusedLine != -1 && focusedIndex != -1) {
        lineContent[focusedLine][focusedIndex].setFocus(false);
        focusedLine = -1;
        focusedIndex = -1;
      }
    }
  }

  void setFocus(int lineIndex, int index) {
    if (focusedLine != -1 && focusedIndex != -1) {
      lineContent[focusedLine][focusedIndex].setFocus(false);
    }

    focusedLine = lineIndex;
    focusedIndex = index;
    lineContent[lineIndex][index].setFocus(true);
  }

  //сдвигает головку ленты и делает ячейку под ней активной
  bool moveLine(int lineIndex, int offset) {
    if (linePointers[lineIndex] + offset < 0 ||
        linePointers[lineIndex] + offset > 2000) {
      return false;
    }

    setActive(lineIndex, false);
    linePointers[lineIndex] += offset;
    setActive(lineIndex, true);

    return true;
  }

  bool moveLineInput(int offset) {
    if (focusedLine == -1) {
      return false;
    }
    if (focusedIndex + offset < 0 || focusedIndex + offset > 2000) {
      return false;
    }
    setFocus(focusedLine, focusedIndex + offset);
    return true;
  }

  //Возвращает символ ленты на месте указателя
  String getSymbol(int lineIndex) {
    return lineContent[lineIndex][linePointers[lineIndex]].symbol;
  }

  bool checkSymbol(String symbol, String predicate) =>
      predicate == "*" ||
      symbol == predicate ||
      (predicate == "_" && symbol == " ");

  //ставит символ на ленту
  void setSymbol(int lineIndex, String symbol) {
    var inputSymbol = symbol == "_"
        ? " "
        : symbol == "*"
            ? getSymbol(lineIndex)
            : symbol;
    lineContent[lineIndex][linePointers[lineIndex]].setSymbol(inputSymbol);
  }

  //ставит символ на ленту и смещает указатель вправо
  void writeSymbol(String symbol) {
    lineContent[focusedLine][focusedIndex].setSymbol(symbol);
    moveLineInput(1);
  }

  //очищает текуший символ ленты и сдвигает указатель влево
  void clearSymbol() {
    lineContent[focusedLine][focusedIndex].setSymbol(" ");
    moveLineInput(-1);
  }

  void setActive(int lineIndex, bool isActive) {
    lineContent[lineIndex][linePointers[lineIndex]].setActive(isActive);
  }
}
