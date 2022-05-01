import 'dart:convert';
import 'dart:developer';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:material_snackbar/snackbar.dart';
import 'package:material_snackbar/snackbar_messenger.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import 'package:mutliline_turing_machine/ui/bottom_split_panel.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:mutliline_turing_machine/ui/referance.dart';
import 'package:mutliline_turing_machine/ui/settings_panel.dart';
import 'package:mutliline_turing_machine/ui/states_list.dart';
import 'package:window_size/window_size.dart';
import 'styles/app_colors.dart';
import 'ui/about_panel.dart';
import 'ui/lines_page.dart';
import 'ui/top_panel.dart';
import 'ui/bottom_panel.dart';
import 'ui/turing_machine_table.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Эмулятор MMT');
    setWindowMinSize(const Size(460, 600));
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Эмулятор Машины Тьюринга',
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

  var lineAnimate = LineAnimationState(true);

  var commentsState = GlobalKey<BottomSplitPanelState>();
  var bottomPanelState = GlobalKey<BottomPanelState>();
  var statesListState = GlobalKey<StatesListState>();

  GlobalKey textOfCountConfigurations = GlobalKey();

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
    key: bottomPanelState,
    textToUpdate: textOfCountConfigurations,
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
    onMakeStep: (sfContext) {
      var text = machine.makeStep();
      statesListState.currentState!.setState(() {});
      tableState.currentState!.updateTableState();
      tableManager!.setCurrentSelectingRowsByRange(
          machine.configuration.currentVatiantIndex, machine.configuration.currentVatiantIndex);
      onScroll();

      if (text != "" && !isShackBarShow) {
        isShackBarShow = true;
        MaterialSnackBarMessenger.of(sfContext).emptyQueue();
        MaterialSnackBarMessenger.of(sfContext)
            .showSnackBar(snackbar: errorSnackBar(text), alignment: Alignment.bottomRight);
      }
    },
    onResetWork: () {
      machine.activator.resetMachine();
      machine.activator.configurationSet.clear();
      statesListState.currentState!.setState(() {});
      tableState.currentState!.updateTableState();
      tableManager!.setCurrentSelectingRowsByRange(
          machine.configuration.currentVatiantIndex, machine.configuration.currentVatiantIndex);
    },
    onStartStopWork: (int timesPerSec, sfContext) {
      if (!machine.activator.isActive) {
        machine.activator.startMachine(timesPerSec, () {
          var message = machine.makeStep();

          if (message != "" && !isShackBarShow) {
            machine.activator.stopMachine();
            bottomPanelState.currentState!.setState(() {});

            isShackBarShow = true;
            MaterialSnackBarMessenger.of(sfContext).emptyQueue();
            MaterialSnackBarMessenger.of(sfContext)
                .showSnackBar(snackbar: errorSnackBar(message), alignment: Alignment.bottomRight);
          }

          statesListState.currentState!.setState(() {});
          tableState.currentState!.updateTableState();
          tableManager!.setCurrentSelectingRowsByRange(
              machine.configuration.currentVatiantIndex, machine.configuration.currentVatiantIndex);
          onScroll();
        }, textOfCountConfigurations);
      } else {
        machine.activator.stopMachine();
      }
    },
    onNewSpeed: (int timesPerSec, sfContext) {
      machine.activator.setNewSpeed(timesPerSec, () {
        var message = machine.makeStep();

        if (message != "" && !isShackBarShow) {
          machine.activator.stopMachine();
          bottomPanelState.currentState!.setState(() {});

          isShackBarShow = true;
          MaterialSnackBarMessenger.of(sfContext).emptyQueue();
          MaterialSnackBarMessenger.of(sfContext)
              .showSnackBar(snackbar: errorSnackBar(message), alignment: Alignment.bottomRight);
        }

        statesListState.currentState!.setState(() {});
        tableState.currentState!.updateTableState();
        tableManager!.setCurrentSelectingRowsByRange(
            machine.configuration.currentVatiantIndex, machine.configuration.currentVatiantIndex);
        onScroll();
      });
    },
    onCommentsShow: () {
      commentsState.currentState!.changeCommentsShow();
    },
  );

  bool isShackBarShow = false;

  void onScroll() {
    linePagesState.currentState!.onScroll();
  }

  void updateSelectedState(int newState) {
    statesListState.currentState!.setState(() {
      machine.configuration.currentStateIndex = newState;
    });

    tableState.currentState!.updateTableState();
  }

  MaterialSnackbar errorSnackBar(String text) {
    return MaterialSnackbar(
      onDismiss: () {
        isShackBarShow = false;
      },
      theme: SnackBarThemeData(
          shape: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(6),
              ),
              borderSide: BorderSide(color: Colors.transparent, width: 0)),
          backgroundColor: text == "!" ? AppColors.accent : AppColors.destructive,
          actionTextColor: AppColors.background,
          contentTextStyle: TextStyle(color: AppColors.background)),
      content: Text(
        text == "!" ? "Машина завершила выполнение." : text,
        style: TextStyle(color: AppColors.background),
      ),
    );
  }

  FocusNode commentsFocus = FocusNode();
  FocusNode statesFocus = FocusScopeNode();

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
        animationState: lineAnimate,
        statesFocus: statesFocus,
        bottomSplitState: commentsState,
        machine: machine,
        linesFocus: [for (int i = 0; i < machine.model.countOfLines; i++) FocusNode()],
        commentsFocus: commentsFocus,
        linesPageState: linePagesState,
        tableState: tableState,
        statesListState: statesListState,
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
              minimalSizes: const [204, 396],
              initialWeights: const [0.33, 0.64],
              children: [
                Column(
                  children: [
                    TopPanel(),
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
