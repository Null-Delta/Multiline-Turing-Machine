import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:mutliline_turing_machine/ui/about_panel.dart';
import 'package:mutliline_turing_machine/ui/app_theme.dart';
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
      keyDownHandler: (_) {
        newFile();
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.keyS,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (_) {
        log("ctrl+S");
        saveFile();
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.keyO,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (_) {
        loadFile();
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.f1,
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (_) {
        if (!Navigator.of(context).canPop()) {
          if(machine.activator.isActive)
          {
            machine.activator.stopMachine();
          }
          settings();
        }
        else
        {
          Navigator.of(context).pop();
        }
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.f2,
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (_) {
        if (!Navigator.of(context).canPop()) {
          if(machine.activator.isActive)
          {
            machine.activator.stopMachine();
          }
          aboutApp();
        }
        else
        {
          Navigator.of(context).pop();
        }
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.f3,
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (_) {
        if (!Navigator.of(context).canPop()) {
          if(machine.activator.isActive)
          {
            machine.activator.stopMachine();
          }
          help();
        }
        else
        {
          Navigator.of(context).pop();
        }
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.keyS,
        modifiers: [KeyModifier.control, KeyModifier.shift],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (_) {
       saveAllLines();
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.keyL,
        modifiers: [KeyModifier.control, KeyModifier.shift],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (_) {
        
        loadAllLines();
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.keyC,
        modifiers: [KeyModifier.control, KeyModifier.shift],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (_) {
        
        clearAllLines();
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.bracketRight,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (_) {
        addLine();
      },
    );

    hotKeyManager.register(
      HotKey(
        KeyCode.bracketLeft,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (_) {
        deleteLine();
      },
    );
  }

   


  Timer? timer;
  int savedIndex = 0;
  void startAutoSave(TuringMachine machine) {
    timer = Timer.periodic(
      const Duration(minutes: 3),
      (timer) async {
        if (Platform.isWindows) {
          String savePath = Directory.current.path + "\\save\\autosave" + savedIndex.toString() + ".mmt";
          savedIndex++;
          if (savedIndex == 10) savedIndex = 0;
          File file = File(savePath);
          IOSink sink = file.openWrite();
          String json = jsonEncode(machine.toJson());
          sink.write(json);
          file.create();
        }
      },
    );
  }

  void newFile() {
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
        initialDirectory: Directory.current.path + "\\save",
        dialogTitle: '',
        type: FileType.custom,
        allowedExtensions: ['mmt']);
    if (result != null) {
      log(result.files.first.path!);
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
        initialDirectory: Directory.current.path + "\\save",
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

      machine.filePath = result;
    }
  }

  void settings() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return ChangeNotifierProvider.value(
        value: animationState,
        child: SettingsPanel(
          theme: theme,
        ),
      );
    }));
  }

  void aboutApp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const AboutPanel()));
  }

  void help() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const Reference()));
  }
  
  void saveAllLines() {
    machine.saveLinesJson = jsonEncode(machine.linesToJson());
  }

  void loadAllLines() {
    
      if (machine.saveLinesJson != null) {
        machine.importLinesJson(machine.saveLinesJson!);
        tableState.currentState!.reloadTable();
        linePagesState.currentState!.reBuild();
        bottomSplitState.currentState!.setState(() {});
      }
      
    
      
  }

  void clearAllLines() {
    linePagesState.currentState!.clearAllLines();
  }

  void addLine() {
    if (machine.addLine()) {
      linePagesState.currentState?.setState(() {});
      tableState.currentState!.addLine();
    }
  }

  void deleteLine() {
    if (machine.deleteLine()) {
      linePagesState.currentState?.setState(() {});
      tableState.currentState!.deleteLine();
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
                  onPressed: clearAllLines,
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
