class TuringCommand {
  String input = "";
  String output = "";
  String moveType = "";
}

class TuringMachineVariant {
  List<TuringCommand> comandList = [];
  int toState = -1;

  TuringMachineVariant(int countOfLines) {
    while (countOfLines > 0) {
      comandList.add(TuringCommand());
      countOfLines--;
    }
  }
}

class TuringMachineState {
  String description = "";
  int get countOfVariants => variantList.length;
  List<TuringMachineVariant> variantList = [];
}

class TuringMachineModel {
  int get countOfStates => stateList.length;
  int countOfLines = 1;
  List<TuringMachineState> stateList = [];

  void addState() => stateList.add(TuringMachineState());

  void deleteState(int number) => stateList.removeAt(number);

  void addVariant(int numberOfState) => stateList[numberOfState]
      .variantList
      .add(TuringMachineVariant(countOfLines));

  void deleteVariant(int numberOfState, int numberOfVariant) =>
      stateList[numberOfState].variantList.removeAt(numberOfVariant);

  void addLine() {
    countOfLines++;
    for (int i = 0; i < countOfStates; i++) {
      for (int j = 0; j < stateList[i].countOfVariants; j++) {
        stateList[i].variantList[j].comandList.add(TuringCommand());
      }
    }
  }

  void deleteLine() {
    countOfLines--;
    for (int i = 0; i < countOfStates; i++) {
      for (int j = 0; j < stateList[i].countOfVariants; j++) {
        stateList[i].variantList[j].comandList.removeLast();
      }
    }
  }

  void setComandInVariant(
      int numberOfState,
      int numberOfVariant,
      int numberOfLine,
      String inLetter,
      String outLetter,
      String moveDirection) {
    stateList[numberOfState]
        .variantList[numberOfVariant]
        .comandList[numberOfLine]
        .input = inLetter;
    stateList[numberOfState]
        .variantList[numberOfVariant]
        .comandList[numberOfLine]
        .output = outLetter;
    stateList[numberOfState]
        .variantList[numberOfVariant]
        .comandList[numberOfLine]
        .moveType = moveDirection;
  }

  void setToStateInVariant(
          int numberOfState, int numberOfVariant, int toState) =>
      stateList[numberOfState].variantList[numberOfVariant].toState = toState;

  TuringMachineModel() {
    addState();
    addVariant(0);
  }
}
