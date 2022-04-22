import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:mutliline_turing_machine/ui/state_comments.dart';
import 'package:mutliline_turing_machine/ui/states_list.dart';
import 'styles/app_colors.dart';
import 'ui/lines_page.dart';
import 'ui/top_panel.dart';
import 'ui/bottom_panel.dart';
import 'ui/turing_machine_table.dart';

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

class MainWidget extends StatefulWidget {
  MainWidget({Key? key}) : super(key: key);

  final TuringMachine machine = TuringMachine(TuringMachineModel());

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  late PlutoGridStateManager? tableManager;
  final tableState = GlobalKey<TuringMachineTableState>();

  late var table = TuringMachineTable(
    key: tableState,
    onLoaded: (manager) {
      tableManager = manager;
      bottomPanel.tableManager = manager;
    },
  );

  final GlobalKey<LinesPageState> linePagesState = GlobalKey<LinesPageState>();

  late var bottomPanel = BottomPanel(
    onAddVariant: () {
      tableState.currentState!.addVariant();
    },
    onDeleteVariant: () {
      tableState.currentState!.deleteVariant();
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
        tableState.currentState!.updateTableState();
      }
    },
    onMakeStep: () {
      log("scroll1");
      widget.machine.makeStep();
      onScroll();
    },
  );

  late var linesPage = LinesPage(key: linePagesState);

  void onScroll() {
    linePagesState.currentState!.onScroll();
  }

  void updateSelectedState(int newState) {
    setState(() {
      widget.machine.currentStateIndex = newState;
    });

    tableState.currentState!.updateTableState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: MachineInherit(
        machine: widget.machine,
        child: Center(
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
                Column(
                  children: [
                    const TopPanel(),
                    linesPage,
                  ],
                ),
                Column(
                  children: [
                    bottomPanel,
                    Expanded(
                      child: Row(
                        children: [
                          StatesList(
                            onStateSelect: (index) {
                              updateSelectedState(index);
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
                                children: [table, const StateComments()],
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
      ),
    );
  }
}
