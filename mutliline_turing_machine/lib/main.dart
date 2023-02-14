import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_window_close/flutter_window_close.dart';
import 'package:material_snackbar/snackbar.dart';
import 'package:material_snackbar/snackbar_messenger.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'package:mutliline_turing_machine/styles/app_themes.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import 'package:mutliline_turing_machine/ui/app_theme.dart';
import 'package:mutliline_turing_machine/ui/bottom_split_panel.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:mutliline_turing_machine/ui/settings_panel.dart';
import 'package:mutliline_turing_machine/ui/states_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_size/window_size.dart';
import 'ui/lines_page.dart';
import 'ui/onExitSave.dart';
import 'ui/top_panel.dart';
import 'ui/bottom_panel.dart';
import 'ui/turing_machine_table.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hotKeyManager.unregisterAll();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Эмулятор MMT');
    setWindowMinSize(const Size(540, 600));
  }

  if (Platform.isWindows) {
    Directory((await getApplicationDocumentsDirectory()).path +
            "\\Multiline Turing Machine Saves")
        .create()
        .then((Directory directory) {
      log(directory.path);
    });
  }

  if (Platform.isMacOS) {
    Directory((await getApplicationDocumentsDirectory()).path +
            "/Multiline Turing Machine Saves")
        .create()
        .then((Directory directory) {
      log(directory.path);
    });
  }

  var prefs = await SharedPreferences.getInstance();
  var theme = AppTheme();
  theme.setMode((prefs.getBool("use_system_theme") ?? true)
      ? 0
      : (prefs.getInt("selected_theme") ?? 0) + 1);

  runApp(MyApp(
    theme: theme,
  ));
}

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  MyApp({Key? key, required this.theme}) : super(key: key);
  AppTheme theme;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    widget.theme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Эмулятор Машины Тьюринга',
      darkTheme: dark,
      theme: light,
      themeMode: widget.theme.getMode(),
      home: MainWidget(
        theme: widget.theme,
      ),
    );
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({Key? key, required this.theme}) : super(key: key);

  final AppTheme theme;
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

  TuringMachineTable table() {
    log("table update");
    return TuringMachineTable(
      key: tableState,
      topFocus: bottomPanel.topFocus,
      rightFocus: commentsFocus,
      onLoaded: (manager) {
        tableManager = manager;
        bottomPanel.tableManager = manager;
      },
    );
  }

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
      if (machine.model.deleteState(machine.configuration.currentStateIndex)) {
        if (machine.configuration.currentStateIndex >=
            machine.model.countOfStates) {
          machine.configuration.currentStateIndex =
              machine.model.countOfStates - 1;
        }
        tableState.currentState!.updateTableState();
        //tableState.currentState!.setState(() {});
        statesListState.currentState!.setState(() {});
      }
    },
    onMakeStep: (sfContext) {
      var text = machine.makeStep();
      statesListState.currentState!.setState(() {});
      tableState.currentState!.updateTableState();
      tableManager!.setCurrentSelectingRowsByRange(
          machine.configuration.currentVatiantIndex,
          machine.configuration.currentVatiantIndex);
      onScroll();

      if (text != "" && !isShackBarShow) {
        isShackBarShow = true;
        MaterialSnackBarMessenger.of(sfContext).emptyQueue();
        MaterialSnackBarMessenger.of(sfContext).showSnackBar(
            snackbar: errorSnackBar(text), alignment: Alignment.bottomRight);
      }
    },
    onResetWork: () {
      machine.activator.resetMachine();
      machine.activator.configurationSet.clear();
      statesListState.currentState!.setState(() {});
      tableState.currentState!.updateTableState();
      tableManager!.setCurrentSelectingRowsByRange(
          machine.configuration.currentVatiantIndex,
          machine.configuration.currentVatiantIndex);
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
            MaterialSnackBarMessenger.of(sfContext).showSnackBar(
                snackbar: errorSnackBar(message),
                alignment: Alignment.bottomRight);
          }

          statesListState.currentState!.setState(() {});
          tableState.currentState!.updateTableState();
          tableManager!.setCurrentSelectingRowsByRange(
              machine.configuration.currentVatiantIndex,
              machine.configuration.currentVatiantIndex);
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
          MaterialSnackBarMessenger.of(sfContext).showSnackBar(
              snackbar: errorSnackBar(message),
              alignment: Alignment.bottomRight);
        }

        statesListState.currentState!.setState(() {});
        tableState.currentState!.updateTableState();
        tableManager!.setCurrentSelectingRowsByRange(
            machine.configuration.currentVatiantIndex,
            machine.configuration.currentVatiantIndex);
        onScroll();
      });
    },
    onCommentsShow: () {
      commentsState.currentState!.changeCommentsShow();
    },
  );

  bool isShackBarShow = false;
  bool inAnotherPage = false;

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
          backgroundColor: text == "!"
              ? Theme.of(context).primaryColor
              : Theme.of(context).colorScheme.error,
          actionTextColor: Theme.of(context).colorScheme.background,
          contentTextStyle:
              TextStyle(color: Theme.of(context).colorScheme.background)),
      content: Text(
        text == "!" ? "Машина завершила выполнение." : text,
        style: TextStyle(color: Theme.of(context).colorScheme.background),
      ),
    );
  }

  FocusNode commentsFocus = FocusNode();
  FocusNode statesFocus = FocusScopeNode();

  GlobalKey<LinesPageState> linePagesState = GlobalKey<LinesPageState>();

  @override
  void initState() {
    FlutterWindowClose.setWindowShouldCloseHandler(() async {
      return await onExitSave(context, machine);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    linePagesState = GlobalKey<LinesPageState>();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: MachineInherit(
        animationState: lineAnimate,
        statesFocus: statesFocus,
        bottomPanel: bottomPanelState,
        bottomSplitState: commentsState,
        machine: machine,
        linesFocus: [
          for (int i = 0; i < machine.model.countOfLines; i++) FocusNode()
        ],
        commentsFocus: commentsFocus,
        linesPageState: linePagesState,
        tableState: tableState,
        statesListState: statesListState,
        theme: widget.theme,
        child: Center(
          child: MultiSplitViewTheme(
            data: MultiSplitViewThemeData(
              dividerThickness: 2,
              dividerPainter: DividerPainter(
                backgroundColor: Theme.of(context).highlightColor,
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
                            color: Theme.of(context).highlightColor,
                          ),
                          Expanded(
                            child: MultiSplitViewTheme(
                              data: MultiSplitViewThemeData(
                                dividerThickness: 2,
                                dividerPainter: DividerPainter(
                                  backgroundColor:
                                      Theme.of(context).highlightColor,
                                ),
                              ),
                              child: BottomSplitPanel(
                                key: commentsState,
                                table: table(),
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
