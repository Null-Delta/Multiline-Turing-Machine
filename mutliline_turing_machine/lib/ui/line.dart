import 'package:flutter/material.dart';
import '../styles/app_colors.dart';
import 'line_cell.dart';

class Line extends StatefulWidget {
  const Line({Key? key}) : super(key: key);

  @override
  State<Line> createState() => _LineState();
}

class _LineState extends State<Line> {
  List<LineCell> cells = [];
  int centerPosition = 0;
  int countOfCells = 0;

  String letter = "a";
  bool isActive = false;
  bool isFocus = false;

  @override
  Widget build(BuildContext build) {
    //
    List<Positioned> k = [];
    for (int i = 0; i < MediaQuery.of(context).size.width/30+2; i++) {
      cells.add(const LineCell());
      k.add(Positioned(top: 4, left: i*30+3, child: cells[i+LeftPosition]));
    }
    centerPosition = 50;
    countOfCells = 100;
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
          child: Stack(alignment: const Alignment(0, 0),
            children: k
          )
        ),
      ),
    );
  }
}
