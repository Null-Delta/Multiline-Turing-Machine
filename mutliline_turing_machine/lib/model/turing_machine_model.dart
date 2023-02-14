import 'dart:developer';

class TuringCommand {
  String input = "*";
  String output = "*";
  String moveType = "_";

  static TuringCommand? parse(String value) {
    log(value);
    String letters = value.replaceAll(RegExp(r' '), "");

    log(letters);

    if (letters.isEmpty) {
      return TuringCommand.init('*', '*', '_');
    } else {
      if (letters.length == 3 && letters[2].contains(RegExp("[>|<|_|Ю|Б]"))) {
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

  TuringCommand.init(this.input, this.output, String move) {
    moveType = move == "Ю"
        ? ">"
        : move == "Б"
            ? "<"
            : move;
  }

  TuringCommand();
}

class TuringMachineVariant {
  List<TuringCommand> commandList = [];
  int toState = -1;

  String info() {
    var result = "      ";
    for (int i = 0; i < commandList.length; i++) {
      result += commandList[i].toString() + " | ";
    }
    result += "$toState\n";
    return result;
  }

  TuringMachineVariant(int countOfLines, int state) {
    while (countOfLines > 0) {
      commandList.add(TuringCommand());
      countOfLines--;
    }
    toState = state;
  }

  TuringMachineVariant.fromCommandListAndToState(
      this.commandList, this.toState);
}

class TuringMachineState {
  int get countOfVariants => ruleList.length;
  List<TuringMachineVariant> ruleList = [];

  String info() {
    String result = "";
    result += "    variants:\n";

    for (int variantIndex = 0; variantIndex < ruleList.length; variantIndex++) {
      result += "    variant $variantIndex:\n";
      result += ruleList[variantIndex].info();
    }
    return result;
  }

  TuringMachineState.fromRuleList(this.ruleList);
  TuringMachineState();
}

class TuringMachineModel {
  String description = "";
  int get countOfStates => stateList.length;
  int countOfLines = 1;
  List<TuringMachineState> stateList = [];

  void addState() {
    stateList.add(TuringMachineState());
    stateList.last.ruleList
        .add(TuringMachineVariant(countOfLines, stateList.length - 1));
  }

  bool deleteState(int number) {
    if (countOfStates > 1) {
      for (int i = 0; i < stateList.length; i++) {
        for (int j = 0; j < stateList[i].ruleList.length; j++) {
          if (stateList[i].ruleList[j].toState > number) {
            stateList[i].ruleList[j].toState -= 1;
          }
        }
      }
      stateList.removeAt(number);
      return true;
    }
    return false;
  }

  void addVariant(int numberOfState, int atIndex) => stateList[numberOfState]
      .ruleList
      .insert(atIndex, TuringMachineVariant(countOfLines, numberOfState));

  void deleteVariant(int numberOfState, int numberOfVariant) =>
      stateList[numberOfState].ruleList.removeAt(numberOfVariant);

  void addLine() {
    countOfLines++;
    for (int i = 0; i < countOfStates; i++) {
      for (int j = 0; j < stateList[i].countOfVariants; j++) {
        stateList[i].ruleList[j].commandList.add(TuringCommand());
      }
    }
  }

  void deleteLine() {
    countOfLines--;
    for (int i = 0; i < countOfStates; i++) {
      for (int j = 0; j < stateList[i].countOfVariants; j++) {
        stateList[i].ruleList[j].commandList.removeLast();
      }
    }
  }

  void setComandInVariant(int numberOfState, int numberOfVariant,
      int numberOfLine, TuringCommand command) {
    stateList[numberOfState]
        .ruleList[numberOfVariant]
        .commandList[numberOfLine] = command;
  }

  void setToStateInVariant(
          int numberOfState, int numberOfVariant, int toState) =>
      stateList[numberOfState].ruleList[numberOfVariant].toState = toState;

  void replaceVariants(int state, List<int> indexes, int to) {
    List<TuringMachineVariant> replacingRules = [];

    stateList[state].ruleList.asMap().forEach((key, value) {
      if (indexes.contains(key)) {
        replacingRules.add(value);
      }
    });

    stateList[state]
        .ruleList
        .removeWhere((element) => replacingRules.contains(element));

    stateList[state].ruleList.insertAll(to, replacingRules);
  }

  TuringMachineModel() {
    addState();
  }

  String info() {
    String result = "description: $description\n";
    result += "statesCount: ${stateList.length}\n";

    for (int stateIndex = 0; stateIndex < stateList.length; stateIndex++) {
      result += "state $stateIndex:\n";
      result += stateList[stateIndex].info();
    }

    return result;
  }
}
