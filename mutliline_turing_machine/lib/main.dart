import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import 'package:mutliline_turing_machine/ui/state_comments.dart';
import 'package:mutliline_turing_machine/ui/states_list.dart';
import 'styles/app_colors.dart';
import 'ui/top_panel.dart';
import 'ui/bottom_panel.dart';
import 'ui/turing_machine_table.dart';
import 'dart:developer' as developer;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Симулятор Машины Тьюринга',
      theme: ThemeData(
        fontFamily: "Inter",
        backgroundColor: AppColors.background,
        primarySwatch: MaterialColor(AppColors.accent.value, {
          50: AppColors.accent,
          100: AppColors.accent,
          200: AppColors.accent,
          300: AppColors.accent,
          400: AppColors.accent,
          500: AppColors.accent,
          600: AppColors.accent,
          700: AppColors.accent,
          800: AppColors.accent,
          900: AppColors.accent,
        }),
      ),
      home: MainWidget(),
    );
  }
}

// ignore: must_be_immutable
class MainWidget extends StatefulWidget {
  MainWidget({Key? key}) : super(key: key);

  final TuringMachine machine = TuringMachine(TuringMachineModel());
  PlutoGridStateManager? tableManager;

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  late var table = TuringMachineTable(
    machine: widget.machine,
    onLoaded: (manager) {
      widget.tableManager = manager;
      bottomPanel.tableManager = manager;
    },
  );

  late var bottomPanel = BottomPanel(
    machine: widget.machine,
    onAddVariant: () {
      table.addVariant();
    },
    onDeleteVariant: () {
      table.deleteVariant();
    },
    onAddState: () {
      setState(() {
        widget.machine.model.addState();
      });
    },
    onDeleteState: () {
      if (widget.machine.model.countOfStates > 1) {
        setState(
          () {
            widget.machine.model.deleteState(widget.machine.currentStateIndex);
            if (widget.machine.currentStateIndex >=
                widget.machine.model.countOfStates) {
              widget.machine.currentStateIndex =
                  widget.machine.model.countOfStates - 1;
            }
          },
        );
        table.changeState();
      }
    },
  );

  void updateSelectedState(int newState) {
    setState(() {
      widget.machine.currentStateIndex = newState;
    });

    table.changeState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: MultiSplitViewTheme(
          data: MultiSplitViewThemeData(
            dividerThickness: 2,
            dividerPainter: DividerPainter(
              backgroundColor: AppColors.highlight,
            ),
          ),
          child: MultiSplitView(
            antiAliasingWorkaround: false,
            axis: Axis.vertical,
            minimalSize: 256,
            children: [
              TopPanel(
                machine: widget.machine,
              ),
              Column(
                children: [
                  bottomPanel,
                  Expanded(
                    child: Row(
                      children: [
                        StatesList(
                          machine: widget.machine,
                          onStateSelect: (index) {
                            updateSelectedState(index);
                            //widget.tableManager
                          },
                        ),
                        Container(
                          width: 2,
                          color: AppColors.highlight,
                        ),
                        Expanded(
                          child: MultiSplitViewTheme(
                            data: MultiSplitViewThemeData(
                              dividerThickness: 2,
                              dividerPainter: DividerPainter(
                                backgroundColor: AppColors.highlight,
                              ),
                            ),
                            child: MultiSplitView(
                              antiAliasingWorkaround: false,
                              axis: Axis.horizontal,
                              resizable: true,
                              minimalSize: 256,
                              initialWeights: const [0.7, 0.3],
                              children: [
                                table,
                                StateComments(machine: widget.machine)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
