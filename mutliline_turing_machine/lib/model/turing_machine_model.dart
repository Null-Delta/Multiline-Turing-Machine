import 'package:flutter/cupertino.dart';

class TuringCommand {
  String input = "*";
  String output = "*";
  String moveType = "_";

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

  TuringMachineVariant.fromCommandListAndToState(this.commandList, this.toState);
}

class TuringMachineState {
  int get countOfVariants => ruleList.length;
  List<TuringMachineVariant> ruleList = [];

  String info() {
    String result = "";
    result += "    variants:\n";

    for (int variantIndex = 0;
        variantIndex < ruleList.length;
        variantIndex++) {
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

  void deleteState(int number) => stateList.removeAt(number);

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

  void replaceVariants(int numberOfState, int from, int to) {
    var element = stateList[numberOfState].ruleList.removeAt(from);
    stateList[numberOfState].ruleList.insert(to, element);
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
