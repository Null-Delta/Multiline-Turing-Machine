import 'package:flutter/material.dart';
import '../styles/app_colors.dart';

class LineCell extends StatefulWidget {
  const LineCell({Key? key}) : super(key: key);

  @override
  State<LineCell> createState() => _LineCellState();
}

class _LineCellState extends State<LineCell> {
  String letter = 'A';
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
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: !isActive
                  ? BoxDecoration(
                      border: Border.all(width: 2, color: AppColors.highlight),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: AppColors.background,
                    )
                  : BoxDecoration(
                      color: AppColors.accent,
                    ),
              child: Align(
                alignment: Alignment.center,
                child: isFocus
                    ? Stack(
                        alignment: Alignment.center,
                        children: [
                          Text(
                            letter,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: !isActive
                                  ? AppColors.text
                                  : AppColors.background,
                            ),
                          ),
                          Container(
                            width: 16.0,
                            height: 3.0,
                            margin: const EdgeInsets.only(
                              top: 32,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                decoration:
                                    BoxDecoration(color: AppColors.background),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        letter,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color:
                              !isActive ? AppColors.text : AppColors.background,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
