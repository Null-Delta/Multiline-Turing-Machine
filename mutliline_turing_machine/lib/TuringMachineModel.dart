import 'package:flutter/material.dart';

class TuringCommand{
  String input = "";
  String output = "";
  String moveType = "";
}

class TuringMachineVariant {        
  List<TuringCommand> comandList = [];
  int toState = -1;

  TuringMachineVariant(int countOfLines){
    while (countOfLines > 0)
    {
      comandList.add(new TuringCommand());
      countOfLines--;
    }
  }
}

class TuringMachineState {
  String description = "";  
  int countOfVariants = 0;                   
  List<TuringMachineVariant> variantList = [];
}

class TuringMachineModel {
  int countOfStates = 0;
  int countOfLines = 1;                       
  List<TuringMachineState> stateList = [];

  void AddState()
  {
    countOfStates++;
    stateList.add(new TuringMachineState());
  }
  void DeleteState(int number)
  {
    countOfStates--;
    stateList.removeAt(number);
  }
  void AddVariant(int numberOfState)
  {
    stateList[numberOfState].countOfVariants++;
    stateList[numberOfState].variantList.add(new TuringMachineVariant(countOfLines));
  }
  void DeleteVariant(int numberOfState, int numberOfVariant)
  {
    stateList[numberOfState].countOfVariants--;
    stateList[numberOfState].variantList.removeAt(numberOfVariant);
  }
  void setComandInVariant(int numberOfState, int numberOfVariant, int numberOfLine, String inLetter, String outLetter, String moveDirection)
  {
    stateList[numberOfState].variantList[numberOfVariant].comandList[numberOfLine].input = inLetter;
    stateList[numberOfState].variantList[numberOfVariant].comandList[numberOfLine].output = outLetter;
    stateList[numberOfState].variantList[numberOfVariant].comandList[numberOfLine].moveType = moveDirection;
  }
}