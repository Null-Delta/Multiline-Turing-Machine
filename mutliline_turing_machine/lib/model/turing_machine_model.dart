class TuringCommand {
  String input = "";
  String output = "";
  String moveType = "";

  static TuringCommand? parse(String value) {
    String letters = value.replaceAll(RegExp(r' '), "");
    if (letters.isEmpty) {
      return TuringCommand.init('*', '*', '_');
    } else {
      if (letters.length == 3 && letters[2].contains(RegExp("[>|<|_]"))) {
        return TuringCommand.init(letters[0], letters[1], letters[2]);
      } else {
        return null;
      }
    }
  }

  @override
  String toString() {
    return input + " " + output + " " + moveType;
  }

  TuringCommand.init(this.input, this.output, this.moveType);
  TuringCommand();
}

class TuringMachineVariant {
  List<TuringCommand> commandList = [];
  int toState = -1;

  TuringMachineVariant(int countOfLines) {
    while (countOfLines > 0) {
      commandList.add(TuringCommand());
      countOfLines--;
    }
  }

  String info() {
    var result = "      ";
    for (int i = 0; i < commandList.length; i++) {
      result += commandList[i].toString() + " | ";
    }
    result += "$toState\n";
    return result;
  }
}

class TuringMachineState {
  String description = "";
  int get countOfVariants => variantList.length;
  List<TuringMachineVariant> variantList = [];

  String info() {
    String result = "  description: $description\n";
    result += "    variants:\n";

    for (int variantIndex = 0;
        variantIndex < variantList.length;
        variantIndex++) {
      result += "    variant $variantIndex:\n";
      result += variantList[variantIndex].info();
    }
    return result;
  }
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
        stateList[i].variantList[j].commandList.add(TuringCommand());
      }
    }
  }

  void deleteLine() {
    countOfLines--;
    for (int i = 0; i < countOfStates; i++) {
      for (int j = 0; j < stateList[i].countOfVariants; j++) {
        stateList[i].variantList[j].commandList.removeLast();
      }
    }
  }

  void setComandInVariant(int numberOfState, int numberOfVariant,
      int numberOfLine, TuringCommand command) {
    stateList[numberOfState]
        .variantList[numberOfVariant]
        .commandList[numberOfLine] = command;
  }

  void setToStateInVariant(
          int numberOfState, int numberOfVariant, int toState) =>
      stateList[numberOfState].variantList[numberOfVariant].toState = toState;

  void replaceVariants(int numberOfState, int from, int to) {
    var tmp = stateList[numberOfState].variantList[from];
    stateList[numberOfState].variantList[from] =
        stateList[numberOfState].variantList[to];
    stateList[numberOfState].variantList[to] = tmp;
  }

  TuringMachineModel() {
    addState();
    addVariant(0);
  }

  String info() {
    var result = "statesCount: ${stateList.length}\n";

    for (int stateIndex = 0; stateIndex < stateList.length; stateIndex++) {
      result += "state $stateIndex:\n";
      result += stateList[stateIndex].info();
    }
    //developer.log(result);

    return result;
  }
}
