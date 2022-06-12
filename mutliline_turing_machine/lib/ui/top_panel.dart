import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:mutliline_turing_machine/ui/about_panel.dart';
import 'package:mutliline_turing_machine/ui/app_theme.dart';
import 'package:mutliline_turing_machine/ui/bottom_panel.dart';
import 'package:mutliline_turing_machine/ui/bottom_split_panel.dart';
import 'package:mutliline_turing_machine/ui/custom_popup.dart';
import 'package:mutliline_turing_machine/ui/lines_page.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:mutliline_turing_machine/ui/referance.dart';
import 'package:mutliline_turing_machine/ui/settings_panel.dart';
import 'package:mutliline_turing_machine/ui/states_list.dart';
import 'package:mutliline_turing_machine/ui/turing_machine_table.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import 'snackbar.dart';

class TopPanel extends StatefulWidget {
  const TopPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<TopPanel> createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
  static const double iconSize = 28;

  late TuringMachine machine = MachineInherit.of(context)!.machine;
  late GlobalKey<TuringMachineTableState> tableState =
      MachineInherit.of(context)!.tableState;
  late GlobalKey<BottomPanelState> bottomPanel =
      MachineInherit.of(context)!.bottomPanel;
  late GlobalKey<LinesPageState> linePagesState =
      MachineInherit.of(context)!.linesPageState;
  late GlobalKey<BottomSplitPanelState> bottomSplitState =
      MachineInherit.of(context)!.bottomSplitState;
  late GlobalKey<StatesListState> statesListState =
      MachineInherit.of(context)!.statesListState;
  late LineAnimationState animationState =
      MachineInherit.of(context)!.animationState;
  late AppTheme theme = MachineInherit.of(context)!.theme;

  void loadTopHotKeys(
      TuringMachine machine,
      GlobalKey<TuringMachineTableState> tableState,
      GlobalKey<LinesPageState> linePagesState,
      GlobalKey<BottomSplitPanelState> bottomSplitState,
      GlobalKey<StatesListState> statesListState,
      LineAnimationState animationState) {
    hotKeyManager.register(
      HotKey(
        KeyCode.keyN,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyUpHandler: (_) {
        newFile();
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.keyS,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyUpHandler: (_) {
        //log("ctrl+S");
        saveFile();
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.keyO,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyUpHandler: (_) {
        loadFile();
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.f1,
        scope: HotKeyScope.inapp,
      ),
      keyUpHandler: (_) {
        if (!Navigator.of(context).canPop()) {
          if (machine.activator.isActive) {
            machine.activator.stopMachine();
          }
          settings();
        } else {
          Navigator.of(context).pop();
        }
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.f2,
        scope: HotKeyScope.inapp,
      ),
      keyUpHandler: (_) {
        if (!Navigator.of(context).canPop()) {
          if (machine.activator.isActive) {
            machine.activator.stopMachine();
          }
          aboutApp();
        } else {
          Navigator.of(context).pop();
        }
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.f3,
        scope: HotKeyScope.inapp,
      ),
      keyUpHandler: (_) {
        if (!Navigator.of(context).canPop()) {
          if (machine.activator.isActive) {
            machine.activator.stopMachine();
          }
          help();
        } else {
          Navigator.of(context).pop();
        }
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.f5,
        scope: HotKeyScope.inapp,
      ),
      keyUpHandler: (_) async {
        await createAutoSave();
        Snackbar.create("Сохранение...", context, isError: false, sec: 1);
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.keyS,
        modifiers: [KeyModifier.control, KeyModifier.shift],
        scope: HotKeyScope.inapp,
      ),
      keyUpHandler: (_) {
        saveAllLines();
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.keyL,
        modifiers: [KeyModifier.control, KeyModifier.shift],
        scope: HotKeyScope.inapp,
      ),
      keyUpHandler: (_) {
        loadAllLines();
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.keyC,
        modifiers: [KeyModifier.control, KeyModifier.shift],
        scope: HotKeyScope.inapp,
      ),
      keyUpHandler: (_) {
        if (machine.activator.isHasConfiguration) {
          clearAllLines();
        }
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.bracketRight,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyUpHandler: (_) {
        addLine();
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.bracketLeft,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyUpHandler: (_) {
        deleteLine();
      },
    );
  }

  Timer? timer;
  int savedIndex = 0;
  void startAutoSave(TuringMachine machine) {
    timer = Timer.periodic(
      const Duration(minutes: 3),
      (_) async {
        createAutoSave();
      },
    );
  }

  Future<void> createAutoSave() async {
    if (Platform.isWindows) {
      String savePath = Directory.current.path +
          "\\saves\\autosave" +
          savedIndex.toString() +
          ".mmt";
      savedIndex = (savedIndex + 1) % 10;
      File file = File(savePath);
      IOSink sink = file.openWrite();
      String json = jsonEncode(machine.toJson());
      sink.write(json);
      file.create();
    }
  }

  void newFile() async {
    await createAutoSave();
    Snackbar.create("Предыдущий файл был сохранён.", context, isError: false, sec: 1);
    if (machine.activator.isHasConfiguration) {
      machine.activator.resetMachine();
      machine.activator.configurationSet.clear();
      statesListState.currentState!.setState(() {});
      tableState.currentState!.updateTableState();
      bottomPanel.currentState!.setState(() {});
    }
    TuringMachine emptyMachine = TuringMachine(TuringMachineModel());
    machine.filePath = null;
    machine.loadFromJson(emptyMachine.toJson());
    tableState.currentState!.reloadTable();
    statesListState.currentState!.setState(() {});
    linePagesState.currentState!.reBuild();
    bottomSplitState.currentState!.setState(() {});
    
  }

  Future<void> loadFile() async {
    
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        initialDirectory: Platform.isWindows ? "saves" : "",
        dialogTitle: '',
        type: FileType.custom,
        allowedExtensions: ['mmt']);
    if (result != null) {
      await createAutoSave();
      Snackbar.create("Предыдущий файл был сохранён.", context, isError: false, sec: 1);
      if (machine.activator.isHasConfiguration) {
        machine.activator.resetMachine();
        machine.activator.configurationSet.clear();
        statesListState.currentState!.setState(() {});
        tableState.currentState!.updateTableState();
        bottomPanel.currentState!.setState(() {});
      }
      File file = File(result.files.first.path!);
      String json = await file.readAsString();

      machine.loadFromJson(jsonDecode(json));
      machine.filePath = result.files.first.path;

      tableState.currentState!.reloadTable();
      statesListState.currentState!.setState(() {});
      linePagesState.currentState!.reBuild();
      bottomSplitState.currentState!.setState(() {});
    }
  }

  Future<void> saveFile() async {
    String? result = await FilePicker.platform.saveFile(
        initialDirectory: Platform.isWindows ? "saves" : "",
        dialogTitle: '',
        fileName: 'save.mmt',
        type: FileType.custom,
        allowedExtensions: ['mmt']);

    if (result != null) {
      if (machine.activator.isHasConfiguration) {
        machine.activator.resetMachine();
        machine.activator.configurationSet.clear();
        statesListState.currentState!.setState(() {});
        tableState.currentState!.updateTableState();
        bottomPanel.currentState!.setState(() {});
      }
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

      machine.filePath = result;
      Snackbar.create("Файл сохранён.", context, isError: false, sec: 1);
    }
  }

  void settings() {
    if (machine.activator.isActive) {
      machine.activator.stopMachine();
      bottomSplitState.currentState!.setState(() {});
      bottomPanel.currentState!.setState(() {});
    }
    Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
      return ChangeNotifierProvider.value(
        value: animationState,
        child: SettingsPanel(
          theme: theme,
        ),
      );
    }));
  }

  void aboutApp() {
    if (machine.activator.isActive) {
      machine.activator.stopMachine();
      bottomPanel.currentState!.setState(() {});
    }
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const AboutPanel()));
  }

  void help() {
    if (machine.activator.isActive) {
      machine.activator.stopMachine();
      bottomPanel.currentState!.setState(() {});
    }
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (context) => const Reference()));
  }

  void saveAllLines() {
    machine.saveLinesJson = jsonEncode(machine.linesToJson());
    Snackbar.create("Ленты сохранены.", context, isError: false, sec: 1);
  }

  void loadAllLines() {
    if (machine.activator.isActive || machine.activator.isHasConfiguration) {
      Snackbar.create(
          "Нельзя загружать ленты во время работы машины.", context);
    } else {
      if (machine.saveLinesJson != null) {
        if (machine.activator.isHasConfiguration) {
        machine.activator.resetMachine();
        machine.activator.configurationSet.clear();
        statesListState.currentState!.setState(() {});
        tableState.currentState!.updateTableState();
        bottomPanel.currentState!.setState(() {});
       }
        machine.importLinesJson(machine.saveLinesJson!);
        tableState.currentState!.reloadTable();
        linePagesState.currentState!.reBuild();
        bottomSplitState.currentState!.setState(() {});
      } else {
        Snackbar.create("Нет сохранённых лент.", context, sec: 1);
      }
    }
  }

  void clearAllLines() { 
    if (machine.activator.isActive) {
      Snackbar.create("Нельзя очищать ленты во время работы машины.", context);  
    } else {
      if (machine.activator.isHasConfiguration) {
        machine.activator.resetMachine();
        machine.activator.configurationSet.clear();
        statesListState.currentState!.setState(() {});
        tableState.currentState!.updateTableState();
        bottomPanel.currentState!.setState(() {});
      }
      linePagesState.currentState!.clearAllLines();
    }
    
  }

  void addLine() {
    if (machine.activator.isActive) {
      Snackbar.create("Нельзя добавлять ленты во время работы машины.", context);  
    } else {
      if (machine.addLine()) {
      linePagesState.currentState?.setState(() {});
      tableState.currentState!.addLine();
      } else {
        Snackbar.create("Достигнуто максимальное количество лент.", context);
      }
    }
    
  }

  void deleteLine() {
    if (machine.activator.isActive) {
      Snackbar.create(
          "Нельзя удалять ленты во время работы машины.", context);
    } else {
      if (machine.deleteLine()) {
        linePagesState.currentState?.setState(() {});
        tableState.currentState!.deleteLine();
      } else {
        Snackbar.create("Все ленты удалены.", context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    machine = MachineInherit.of(context)!.machine;
    tableState = MachineInherit.of(context)!.tableState;
    linePagesState = MachineInherit.of(context)!.linesPageState;
    bottomSplitState = MachineInherit.of(context)!.bottomSplitState;
    statesListState = MachineInherit.of(context)!.statesListState;
    animationState = MachineInherit.of(context)!.animationState;
    theme = MachineInherit.of(context)!.theme;

    startAutoSave(machine);

    loadTopHotKeys(machine, tableState, linePagesState, bottomSplitState,
        statesListState, animationState);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 6,
            right: 6,
          ),
          height: 40,
          color: Theme.of(context).backgroundColor,
          child: Row(
            children: [
              CustomPopup(
                  tooltip: "Файл",
                  onSelected: (value) => {},
                  initValue: null,
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        height: 32,
                        child: Row(
                          children: [
                            Text(
                              "Новый файл",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Spacer(),
                            Text(
                              "Crtl + N",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        onTap: newFile,
                      ),
                      PopupMenuItem(
                        height: 32,
                        child: Row(
                          children: [
                            Text(
                              "Загрузить",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Spacer(),
                            Text(
                              "Crtl + O",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        onTap: loadFile,
                      ),
                      PopupMenuItem(
                        height: 32,
                        child: Row(
                          children: [
                            Text(
                              "Сохранить как",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Theme.of(context).cardColor,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Spacer(),
                            Text(
                              "Crtl + S",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context)
                                    .cardColor
                                    .withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                        onTap: saveFile,
                      ),
                    ];
                  },
                  child: Image(
                      image: AppImages.file,
                      color: Theme.of(context).cardColor)),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Настройки (F1)",
                child: ElevatedButton(
                  onPressed: settings,
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.settings,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  style: appButtonStyle(context),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "О приложении (F2)",
                child: ElevatedButton(
                  onPressed: aboutApp,
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                        image: AppImages.happy,
                        color: Theme.of(context).cardColor),
                  ),
                  style: appButtonStyle(context),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Справочка (F3)",
                child: ElevatedButton(
                  onPressed: help,
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                        image: AppImages.help,
                        color: Theme.of(context).cardColor),
                  ),
                  style: appButtonStyle(context),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                ),
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Сохранить все ленты (Crtl+Shift+S)",
                child: ElevatedButton(
                  onPressed: saveAllLines,
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                        image: AppImages.save,
                        color: Theme.of(context).cardColor),
                  ),
                  style: appButtonStyle(context),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Загрузить все ленты (Crtl+Shift+L)",
                child: ElevatedButton(
                  onPressed: loadAllLines,
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                        image: AppImages.load,
                        color: Theme.of(context).cardColor),
                  ),
                  style: appButtonStyle(context),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Очистить все ленты (Crtl+Shift+C)",
                child: ElevatedButton(
                  onPressed: () {
                      clearAllLines();
                  },
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                        image: AppImages.clear,
                        color: Theme.of(context).cardColor),
                  ),
                  style: appButtonStyle(context),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Container(
                width: 2,
                color: Theme.of(context).highlightColor,
                height: 16,
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Добавить ленту в конец (Crtl+])",
                child: ElevatedButton(
                  onPressed: addLine,
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                        image: AppImages.addVariantDown,
                        color: Theme.of(context).cardColor),
                  ),
                  style: appButtonStyle(context),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Удалить последнюю ленту (Crtl+[ )",
                child: ElevatedButton(
                  onPressed: deleteLine,
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                        image: AppImages.deleteVariant,
                        color: Theme.of(context).cardColor),
                  ),
                  style: appButtonStyle(context),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 2,
          thickness: 2,
          color: Theme.of(context).highlightColor,
        ),
      ],
    );
  }
}
