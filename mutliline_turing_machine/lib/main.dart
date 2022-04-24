import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import 'package:mutliline_turing_machine/ui/bottom_split_panel.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
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

  var commentsState = GlobalKey<BottomSplitPanelState>();
  var statesListState = GlobalKey<StatesListState>();

  late var table = TuringMachineTable(
    key: tableState,
    topFocus: bottomPanel.topFocus,
    rightFocus: commentsFocus,
    onLoaded: (manager) {
      tableManager = manager;
      bottomPanel.tableManager = manager;
    },
  );

  late var bottomPanel = BottomPanel(
    onAddVariant: () {
      tableState.currentState!.addVariant();
    },
    onDeleteVariant: () {
      tableState.currentState!.deleteVariant();
    },
    onAddState: () {
      statesListState.currentState!.setState(() {
        widget.machine.model.addState();
      });
    },
    onDeleteState: () {
      if (widget.machine.model.countOfStates > 1) {
        setState(
          () {
            widget.machine.model
                .deleteState(widget.machine.configuration.currentStateIndex);
            if (widget.machine.configuration.currentStateIndex >=
                widget.machine.model.countOfStates) {
              widget.machine.configuration.currentStateIndex =
                  widget.machine.model.countOfStates - 1;
            }
          },
        );
        tableState.currentState!.updateTableState();
      }
    },
    onMakeStep: () {
      widget.machine.makeStep();
      statesListState.currentState!.setState(() {});
      tableState.currentState!.updateTableState();
      tableManager!.setCurrentSelectingRowsByRange(
          widget.machine.configuration.currentVatiantIndex,
          widget.machine.configuration.currentVatiantIndex);
      onScroll();
    },
    onStartStopWork: () {
      if (!widget.machine.activator.isActive) {
        widget.machine.activator.startMachine(2, () {
          statesListState.currentState!.setState(() {});
          onScroll();
        });
      } else {
        widget.machine.activator.stopMachine();
      }
    },
    onCommentsShow: () {
      commentsState.currentState!.chaneCommentsShow();
    },
  );

  void onScroll() {
    linePagesState.currentState!.onScroll();
  }

  void updateSelectedState(int newState) {
    statesListState.currentState!.setState(() {
      widget.machine.configuration.currentStateIndex = newState;
    });

    tableState.currentState!.updateTableState();
  }

  FocusNode linesPageFocus = FocusNode();
  FocusNode commentsFocus = FocusNode();

  final GlobalKey<LinesPageState> linePagesState = GlobalKey<LinesPageState>();

  @override
  Widget build(BuildContext context) {
    log("rebuilding");
    return Scaffold(
      backgroundColor: AppColors.background,
      body: MachineInherit(
        machine: widget.machine,
        lineFocus: [
          for (int i = 0; i < widget.machine.model.countOfLines; i++)
            FocusNode()
        ],
        commentsFocus: commentsFocus,
        linesPageState: linePagesState,
        tableState: tableState,
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
                    LinesPage(key: linePagesState),
                  ],
                ),
                Column(
                  children: [
                    bottomPanel,
                    Expanded(
                      child: Row(
                        children: [
                          StatesList(
                            key: statesListState,
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
                              child: BottomSplitPanel(
                                key: commentsState,
                                table: table,
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
