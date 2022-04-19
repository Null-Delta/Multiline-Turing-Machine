import 'dart:developer';

import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import 'line_cell.dart';

class Line extends StatefulWidget {
  const Line({Key? key}) : super(key: key);

  @override
  State<Line> createState() => _LineState();
}

class _LineState extends State<Line> {
  List<Widget> cells = [];
  int centerPosition = 0;
  int countOfCells = 0;

  String letter = "B";
  bool isActive = false;
  bool isFocus = false;

  @override
  Widget build(BuildContext build) {
    //
    centerPosition = 0;
    countOfCells = 100;
    List<Positioned> k = [];
    // сразу отображаем 100 штук
    int countOfCellsOnScreen = (MediaQuery.of(context).size.width/30).toInt();
    log(countOfCellsOnScreen.toString());
    for (int i = 0; i < countOfCellsOnScreen; i++) {
      cells.add(const LineCell(letter: "s" ));
      k.add(Positioned(
        top: 0,
        left: MediaQuery.of(context).size.width/2-14 + (i - countOfCellsOnScreen/2)*30,
        child: cells[i+centerPosition]));
    }

    //
    return GestureDetector(
      onTap: () {

      },
      onSecondaryTap: () {
      },
      child: Align(
        alignment: const Alignment(0.0, 0.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 50,
          child: ListView.separated(padding: EdgeInsets.only(left: -MediaQuery.of(context).size.width/2), scrollDirection: Axis.horizontal ,itemBuilder: (context, index) { return const LineCell(letter: "s" ); },
          separatorBuilder: (context, index) { return const SizedBox( width: 4); },
          itemCount: 50), 
        ),
      ),
    );
  }
}
