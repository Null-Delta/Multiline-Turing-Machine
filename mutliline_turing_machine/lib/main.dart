import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:material_snackbar/snackbar.dart';
import 'package:material_snackbar/snackbar_messenger.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'package:mutliline_turing_machine/styles/app_themes.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import 'package:mutliline_turing_machine/ui/bottom_split_panel.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:mutliline_turing_machine/ui/settings_panel.dart';
import 'package:mutliline_turing_machine/ui/states_list.dart';
import 'package:window_size/window_size.dart';
import 'styles/app_colors.dart';
import 'ui/about_panel.dart';
import 'ui/lines_page.dart';
import 'ui/referance.dart';
import 'ui/top_panel.dart';
import 'ui/bottom_panel.dart';
import 'ui/turing_machine_table.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hotKeyManager.unregisterAll();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('Эмулятор MMT');
    setWindowMinSize(const Size(460, 600));
  }
  Directory(Directory.current.path + "\\save").create().then((Directory directory) {
    log(directory.path);
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Эмулятор Машины Тьюринга',
      darkTheme: dark,
      theme: light,
      themeMode: ThemeMode.system,
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
          backgroundColor: text == "!" ? Theme.of(context).primaryColor : Theme.of(context).errorColor,
          actionTextColor: Theme.of(context).backgroundColor,
          contentTextStyle: TextStyle(color: Theme.of(context).backgroundColor)),
      content: Text(
        text == "!" ? "Машина завершила выполнение." : text,
        style: TextStyle(color: Theme.of(context).backgroundColor),
      ),
    );
  }

  FocusNode commentsFocus = FocusNode();
  FocusNode statesFocus = FocusScopeNode();

  GlobalKey<LinesPageState> linePagesState = GlobalKey<LinesPageState>();

 
  @override
  void initState() {
    FlutterWindowClose.setWindowShouldCloseHandler(() async {
      return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Theme.of(context).backgroundColor,
              titleTextStyle: TextStyle(color: Theme.of(context).cardColor, fontSize: 16, fontWeight: FontWeight.w500),
              shape: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                borderSide: BorderSide(width: 0, color: Colors.transparent),
              ),
              title: const Text('Сохранить файл перед выходом?'),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    if (machine.filePath != null) {
                      File file = File(machine.filePath!);
                      IOSink sink = file.openWrite();
                      String json = jsonEncode(machine.toJson());
                      sink.write(json);
                      file.create();
                      Navigator.of(context).pop(true);
                    } else {
                      String? result = await FilePicker.platform.saveFile(
                          lockParentWindow: true,
                          fileName: 'save.mmt',
                          type: FileType.custom,
                          allowedExtensions: ['mmt']);

                      if (result != null) {
                        if (result.contains('.')) {
                          log("message " + result.indexOf('.').toString());
                          result = result.substring(0, result.indexOf('.'));
                        }
                        result += '.mmt';
                        log(result);
                        File file = File(result);
                        IOSink sink = file.openWrite();
                        String json = jsonEncode(machine.toJson());
                        sink.write(json);
                        file.create();

                        Navigator.of(context).pop(true);
                      }
                    }
                  },
                  child: const Text(' Да '),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).backgroundColor),
                    foregroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: const Text(' Нет '),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Theme.of(context).backgroundColor),
                    foregroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                  ),
                )
              ],
            );
          });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    linePagesState = GlobalKey<LinesPageState>();

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
                                  backgroundColor: Theme.of(context).highlightColor,
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
