import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
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
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.background
        : index == machine.configuration.currentStateIndex
            ? Theme.of(context).hoverColor
            : Theme.of(context).colorScheme.background;
  }

  Color borderColor(int index) {
    return index == machine.configuration.activeState.activeStateIndex
        ? index == machine.configuration.currentStateIndex
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor
        : index == machine.configuration.currentStateIndex
            ? Theme.of(context).highlightColor
            : index == focusedStateIndex
                ? Theme.of(context).highlightColor
                : Theme.of(context).colorScheme.background;
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
        color: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            SizedBox(
              height: 34,
              child: Center(
                child: Text(
                  "Состояния",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).cardColor,
                  ),
                ),
              ),
            ),
            Divider(
              height: 2,
              thickness: 2,
              color: Theme.of(context).highlightColor,
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

                      if (event.isKeyPressed(LogicalKeyboardKey.arrowUp) &&
                          focusedStateIndex == 0) {
                        FocusScope.of(context)
                            .parent!
                            .focusInDirection(TraversalDirection.up);
                      }

                      if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
                        FocusScope.of(context)
                            .parent!
                            .focusInDirection(TraversalDirection.right);
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
                                color: index ==
                                        machine.configuration.activeState
                                            .activeStateIndex
                                    ? index ==
                                            machine
                                                .configuration.currentStateIndex
                                        ? Theme.of(context)
                                            .colorScheme
                                            .background
                                        : Theme.of(context).primaryColor
                                    : Theme.of(context).cardColor,
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
