import 'line_cell_model.dart';
import 'turing_machine.dart';

class TuringMachineConfiguration {
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

  TuringMachineConfiguration(int linesCount) {
    lineContent = List.generate(
        linesCount, (_) => List.generate(2001, (_) => LineCellModel()));

    linePointer = List.generate(linesCount, (_) => 1000);

    for (int i = 0; i < linePointer.length; i++) {
      lineContent[i][linePointer[i]].setActive(true);
    }

    currentStateIndex = 0;
    currentVatiantIndex = -1;
  }

  void clearLine(lineIndex) {
    lineContent[lineIndex] = List.generate(2001, (_) => LineCellModel());
    linePointer[lineIndex] = 1000;
  }

  void addLine() {
    linePointer.add(1000);
    lineContent.add(List.generate(2001, (_) => LineCellModel()));
    lineContent.last[linePointer.last].setActive(true);
  }

  void deleteLine() {
    lineContent.removeLast();
    linePointer.removeLast();
  }

  void setFocus(int lineIndex, bool isFocus) {
    if (isFocus) {
      focusedLine = lineIndex;
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
    var inputSymbol = symbol == "_"
        ? " "
        : symbol == "*"
            ? getSymbol(lineIndex)
            : symbol;
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
}