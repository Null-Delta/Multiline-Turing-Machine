import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_colors.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';

class StatesList extends StatefulWidget {
  const StatesList({Key? key, required this.onStateSelect}) : super(key: key);

  final void Function(int index) onStateSelect;

  @override
  State<StatesList> createState() => _StatesListState();
}

class _StatesListState extends State<StatesList> {
  late TuringMachine machine;

  @override
  Widget build(BuildContext context) {
    machine = MachineInherit.of(context)!.machine;

    return Container(
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
                return GestureDetector(
                  onTap: () => widget.onStateSelect(index),
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: index == machine.activeState.activeStateIndex
                            ? AppColors.accent
                            : index == machine.currentStateIndex
                                ? AppColors.highlight
                                : AppColors.background,
                        width: 2,
                      ),
                      color: index == machine.activeState.activeStateIndex
                          ? AppColors.background
                          : index == machine.currentStateIndex
                              ? AppColors.backgroundDark
                              : AppColors.background,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(6),
                      ),
                    ),
                    height: 36,
                    child: Center(
                      child: Text(
                        "Q${index + 1}",
                        style: TextStyle(
                            color: index == machine.currentStateIndex
                                ? AppColors.text
                                : AppColors.text,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
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
    );
  }
}
