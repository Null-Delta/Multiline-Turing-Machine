import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_colors.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';

class StatesList extends StatefulWidget {
  const StatesList({Key? key, required this.onStateSelect}) : super(key: key);

  final void Function(int index) onStateSelect;

  @override
  State<StatesList> createState() => StatesListState();
}

class StatesListState extends State<StatesList> {
  late TuringMachine machine;

  int focusedStateIndex = -1;
  late FocusScopeNode focusScope;

  Color backgroundColor(int index) {
    return index == machine.configuration.activeState.activeStateIndex
        ? index == machine.configuration.currentStateIndex
            ? AppColors.accent
            : AppColors.background
        : index == machine.configuration.currentStateIndex
            ? AppColors.backgroundDark
            : AppColors.background;
  }

  Color borderColor(int index) {
    return index == machine.configuration.activeState.activeStateIndex
        ? index == machine.configuration.currentStateIndex
            ? AppColors.accent
            : AppColors.accent
        : index == machine.configuration.currentStateIndex
            ? AppColors.highlight
            : index == focusedStateIndex
                ? AppColors.highlight
                : AppColors.background;
  }

  @override
  Widget build(BuildContext context) {
    machine = MachineInherit.of(context)!.machine;
    //var focus = MachineInherit.of(context)!.statesFocus;
    //var textFocus = MachineInherit.of(context)!.commentsFocus;
    return FocusScope(
      //node: focusScope,
      child: Container(
        width: 84,
        color: AppColors.background,
        child: Column(
          children: [
            SizedBox(
              height: 34,
              child: Center(
                child: Text(
                  "Состояния",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
              thickness: 2,
              color: AppColors.highlight,
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(3),
                itemBuilder: (context, index) {
                  return Focus(
                    onFocusChange: (isFocus) {
                      setState(() {
                        if (isFocus) {
                          focusedStateIndex = index;
                        } else {
                          focusedStateIndex = -1;
                        }
                      });
                    },
                    onKey: (node, event) {
                      if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
                        widget.onStateSelect(index);
                        return KeyEventResult.handled;
                      }

                      if (event.isKeyPressed(LogicalKeyboardKey.arrowUp) && focusedStateIndex == 0) {
                        FocusScope.of(context).parent!.focusInDirection(TraversalDirection.up);
                      }

                      if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
                        FocusScope.of(context).parent!.focusInDirection(TraversalDirection.right);
                      }

                      return KeyEventResult.ignored;
                    },
                    child: GestureDetector(
                      onTap: () {
                        if (!machine.activator.isActive) {
                          widget.onStateSelect(index);
                        }
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor(index),
                            width: 2,
                          ),
                          color: backgroundColor(index),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                        height: 36,
                        child: Center(
                          child: Text(
                            "Q${index + 1}",
                            style: TextStyle(
                                color: index == machine.configuration.activeState.activeStateIndex
                                    ? index == machine.configuration.currentStateIndex
                                        ? AppColors.background
                                        : AppColors.accent
                                    : AppColors.text,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 6);
                },
                itemCount: machine.model.countOfStates,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
