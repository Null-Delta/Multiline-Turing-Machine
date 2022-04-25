import 'dart:convert';
import 'dart:developer';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import 'package:mutliline_turing_machine/ui/bottom_split_panel.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:mutliline_turing_machine/ui/referance.dart';
import 'package:mutliline_turing_machine/ui/states_list.dart';
import 'styles/app_colors.dart';
import 'ui/about_panel.dart';
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
      home: const MainWidget(),
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key}) : super(key: key);

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  late TuringMachine machine = TuringMachine(TuringMachineModel());

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
        machine.model.addState();
      });
    },
    onDeleteState: () {
      if (machine.model.countOfStates > 1) {
        setState(
          () {
            machine.model.deleteState(machine.configuration.currentStateIndex);
            if (machine.configuration.currentStateIndex >= machine.model.countOfStates) {
              machine.configuration.currentStateIndex = machine.model.countOfStates - 1;
            }
          },
        );
        tableState.currentState!.updateTableState();
      }
    },
    onMakeStep: () {
      var text = machine.makeStep();
      statesListState.currentState!.setState(() {});
      tableState.currentState!.updateTableState();
      tableManager!.setCurrentSelectingRowsByRange(
          machine.configuration.currentVatiantIndex, machine.configuration.currentVatiantIndex);
      onScroll();

      if (text != "") {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(text));
      }
    },
    onStartStopWork: () {
      if (!machine.activator.isActive) {
        machine.activator.startMachine(32, () {
          statesListState.currentState!.setState(() {});
          onScroll();
        });
      } else {
        machine.activator.stopMachine();
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
      machine.configuration.currentStateIndex = newState;
    });

    tableState.currentState!.updateTableState();
  }

  SnackBar errorSnackBar(String text) {
    return SnackBar(
      shape: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
            width: 0,
          )),
      elevation: 32,
      width: 640,
      backgroundColor: AppColors.destructive,
      behavior: SnackBarBehavior.floating,
      content: Text(
        text,
        style: TextStyle(color: AppColors.background),
      ),
      action: SnackBarAction(
        textColor: AppColors.background,
        label: 'Ладушки',
        onPressed: () {},
      ),
    );
  }

  void importFile(String json) {
    setState(() {
      machine = TuringMachine.fromJson(jsonDecode(json));
      log(machine.configuration.linePointers.length.toString());
    });
  }

  FocusNode commentsFocus = FocusNode();
  GlobalKey<LinesPageState> linePagesState = GlobalKey<LinesPageState>();

  @override
  Widget build(BuildContext context) {
    log("rebuilding");

    log(machine.model.info());
    log(machine.configuration.linePointers.toString());
    linePagesState = GlobalKey<LinesPageState>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: MachineInherit(
        bottomSplitState: commentsState,
        machine: machine,
        linesFocus: [for (int i = 0; i < machine.model.countOfLines; i++) FocusNode()],
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
                    TopPanel(
                      importFile: importFile,
                      // saveLines: () {
                      //   linePagesState.currentState!.saveLines();
                      // },
                      // loadLines: () {
                      //   linePagesState.currentState!.loadLines();
                      // },
                      // clearLines: () {
                      //   linePagesState.currentState!.clearLines();
                      // },
                    ),
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
