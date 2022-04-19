import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styles/app_colors.dart';
import 'dart:developer' as developer;

class LineCell extends StatefulWidget {
  const LineCell({Key? key}) : super(key: key);

  @override
  State<LineCell> createState() => _LineCellState();
}

class _LineCellState extends State<LineCell> {
  String letter = 'A';
  bool isActive = false;
  bool isFocus = false;

  final FocusNode _focusNode = FocusNode();
  late FocusAttachment _focusAttachment;

  @override
  void initState() {
    super.initState();
    developer.log('init');
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext build) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isActive = !isActive;
          isFocus = false;
        });
      },
      onSecondaryTap: () {
        setState(() {
          isFocus = isActive ? !isFocus : isFocus;
        });

        if (isActive && isFocus) {
          _focusAttachment =
              _focusNode.attach(context, onKeyEvent: (node, event) {
            if (_focusAttachment.isAttached && !(isActive && isFocus)) {
              _focusAttachment.detach();
              return KeyEventResult.handled;
            }

            setState(() {
              letter = event.character ?? letter;
            });

            return KeyEventResult.handled;
          });
          _focusAttachment.reparent();
        }
        _focusNode.requestFocus();
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
