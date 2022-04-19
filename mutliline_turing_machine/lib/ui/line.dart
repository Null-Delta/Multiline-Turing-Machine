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
  String letter = "a";
  bool isActive = false;
  bool isFocus = false;

  @override
  Widget build(BuildContext build) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isActive = !isActive;
        });
      },
      onSecondaryTap: () {
        setState(() {
          isFocus = !isFocus;
        });
      },
      child: Align(
        alignment: const Alignment(0.0, 0.0),
        child: SizedBox(
          width: 28.0,
          height: 42.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Container(
              decoration: !isActive
                  ? BoxDecoration(
                      border: Border.all(width: 2, color: AppColors.highlight),
                      borderRadius: const BorderRadius.all(Radius.circular(7)),
                      color: AppColors.background,
                    )
                  : BoxDecoration(
                      color: AppColors.accent,
                    ),
              child: Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      letter,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color:
                            !isActive ? AppColors.text : AppColors.background,
                      ),
                    ),
                    isFocus
                        ? Container(
                            width: 16.0,
                            height: 3.0,
                            margin: const EdgeInsets.only(
                              top: 32,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Container(
                                decoration:
                                    BoxDecoration(color: AppColors.background),
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
