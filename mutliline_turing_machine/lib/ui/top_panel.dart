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
import 'package:mutliline_turing_machine/ui/bottom_split_panel.dart';
import 'package:mutliline_turing_machine/ui/custom_popup.dart';
import 'package:mutliline_turing_machine/ui/lines_page.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:mutliline_turing_machine/ui/referance.dart';
import 'package:mutliline_turing_machine/ui/settings_panel.dart';
import 'package:mutliline_turing_machine/ui/states_list.dart';
import 'package:mutliline_turing_machine/ui/turing_machine_table.dart';
import 'package:provider/provider.dart';
import '../styles/app_colors.dart';

import 'package:file_picker/file_picker.dart';



class TopPanel extends StatefulWidget {
  const TopPanel({
    Key? key,
  }) : super(key: key);

  @override
  State<TopPanel> createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
  static const double iconSize = 28;


  void loadTopHotKeys(TuringMachine machine, GlobalKey<TuringMachineTableState> tableState, GlobalKey<LinesPageState> linePagesState, GlobalKey<BottomSplitPanelState> bottomSplitState, GlobalKey<StatesListState> statesListState, LineAnimationState animationState)
  {
    // новый файл
    hotKeyManager.register(
      HotKey(
        KeyCode.keyN,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
          var emptyMachine = TuringMachine(TuringMachineModel());

          machine.loadFromJson(emptyMachine.toJson());
          tableState.currentState!.reloadTable();
          statesListState.currentState!.setState(() {});
          linePagesState.currentState!.setState(() {});
          bottomSplitState.currentState!.setState(() {});
        },
    );

    //сохранение ленты
    hotKeyManager.register(
      HotKey(
        KeyCode.keyS,
        modifiers: [KeyModifier.control, KeyModifier.shift],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
          machine.saveLinesJson = jsonEncode(machine.linesToJson());
        },
    );
    //загрузка ленты
    hotKeyManager.register(
      HotKey(
        KeyCode.keyL,
        modifiers: [KeyModifier.control, KeyModifier.shift],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        if (machine.saveLinesJson != null) {
          machine.importLinesJson(machine.saveLinesJson!);
          linePagesState.currentState!.setState(() {});
          var count = machine.model.countOfLines;
          if (count != machine.configuration.linePointers.length) {
            for (int i = 0; i < (count - machine.configuration.linePointers.length).abs(); i++) {
              count < machine.configuration.linePointers.length
                  ? {machine.model.addLine(), tableState.currentState!.addLine()}
                  : {machine.model.deleteLine(), tableState.currentState!.deleteLine()};
            }
          }
        }
      },
    );
    //очистка ленты
    hotKeyManager.register(
      HotKey(
        KeyCode.keyC,
        modifiers: [KeyModifier.control, KeyModifier.shift],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
          linePagesState.currentState!.clearAllLines();
        },
    );

    //сохранение
    hotKeyManager.register(
      HotKey(
        KeyCode.keyS,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) async {
        String? result = await FilePicker.platform
            .saveFile(fileName: 'save.mmt', type: FileType.custom, allowedExtensions: ['mmt']);
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
        }
      },
    );

    bool settingsButton = false;
    hotKeyManager.register(
      HotKey(
        KeyCode.f6,
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        if (!settingsButton && !Navigator.of(context).canPop()){
          settingsButton = true;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return ChangeNotifierProvider.value(
                        value: animationState,
                        child: const SettingsPanel(),
                      );
                    }));
        }
      },
      keyUpHandler: (hotKey){
        if (settingsButton){
          settingsButton = false;

        }
      },
    );
    
    bool aboutButton = false;
    hotKeyManager.register(
      HotKey(
        KeyCode.f2,
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        if (!aboutButton && !Navigator.of(context).canPop()){
          aboutButton = true;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutPanel()));
        }
      },
      keyUpHandler: (hotKey){
        if (aboutButton){
          aboutButton = false;

        }
      },
    );

    bool referenceButton = false;
    hotKeyManager.register(
      HotKey(
        KeyCode.f1,
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        if (!referenceButton && !Navigator.of(context).canPop()){
          referenceButton = true;
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Reference()));
        }
      },
      keyUpHandler: (hotKey){
        if (referenceButton){
          referenceButton = false;

        }
      },
    );

    //загрузка
    hotKeyManager.register(
      HotKey(
        KeyCode.keyO,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) async {
        FilePickerResult? result = await FilePicker.platform
            .pickFiles(dialogTitle: '', type: FileType.custom, allowedExtensions: ['mmt']);
        if (result != null) {
          log(result.files.first.path!);
          File file = File(result.files.first.path!);
          String json = await file.readAsString();

          machine.loadFromJson(jsonDecode(json));
          tableState.currentState!.reloadTable();
          statesListState.currentState!.setState(() {});
          linePagesState.currentState!.setState(() {});
          bottomSplitState.currentState!.setState(() {});
        }
      },
    );

    //добавление ленты
    hotKeyManager.register(
      HotKey(
        KeyCode.bracketRight,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        if (machine.addLine()) {
          linePagesState.currentState?.setState(() {});
          tableState.currentState!.addLine();
        }
      },
    );

    //удаление ленты
    hotKeyManager.register(
      HotKey(
        KeyCode.bracketLeft,
        modifiers: [KeyModifier.control],
        scope: HotKeyScope.inapp,
      ),
      keyDownHandler: (hotKey) {
        if (machine.deleteLine()) {
          linePagesState.currentState?.setState(() {});
          tableState.currentState!.deleteLine();
        }
      },
    );
  }



  @override
  Widget build(BuildContext context) {

    //хоткей на настройки
    

    var machine = MachineInherit.of(context)!.machine;
    var tableState = MachineInherit.of(context)!.tableState;
    var linePagesState = MachineInherit.of(context)!.linesPageState;
    var bottomSplitState = MachineInherit.of(context)!.bottomSplitState;
    var statesListState = MachineInherit.of(context)!.statesListState;
    var animationState = MachineInherit.of(context)!.animationState;

    loadTopHotKeys(machine, tableState, linePagesState, bottomSplitState, statesListState, animationState);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 6,
            right: 6,
          ),
          height: 40,
          color: AppColors.background,
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
                        child: Text(
                          "Новый файл (Crtl+N)",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text,
                          ),
                        ),
                        onTap: () {
                          var emptyMachine = TuringMachine(TuringMachineModel());

                          machine.loadFromJson(emptyMachine.toJson());
                          tableState.currentState!.reloadTable();
                          statesListState.currentState!.setState(() {});
                          linePagesState.currentState!.setState(() {});
                          bottomSplitState.currentState!.setState(() {});
                        },
                      ),
                      PopupMenuItem(
                        height: 32,
                        child: Text(
                          "Загрузить (Crtl+O)",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text,
                          ),
                        ),
                        onTap: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(dialogTitle: '', type: FileType.custom, allowedExtensions: ['mmt']);
                          if (result != null) {
                            log(result.files.first.path!);
                            File file = File(result.files.first.path!);
                            String json = await file.readAsString();

                            machine.loadFromJson(jsonDecode(json));
                            tableState.currentState!.reloadTable();
                            statesListState.currentState!.setState(() {});
                            linePagesState.currentState!.setState(() {});
                            bottomSplitState.currentState!.setState(() {});
                          }
                        },
                      ),
                      PopupMenuItem(
                        height: 32,
                        child: Text(
                          "Сохранить как (Crtl+S)",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text,
                          ),
                        ),
                        onTap: () async {
                          String? result = await FilePicker.platform
                              .saveFile(fileName: 'save.mmt', type: FileType.custom, allowedExtensions: ['mmt']);
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
                          }
                        },
                      ),
                    ];
                  },
                  child: const Image(
                    image: AppImages.file,
                  )),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Настройки (F6)",
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return ChangeNotifierProvider.value(
                        value: animationState,
                        child: const SettingsPanel(),
                      );
                    }));
                  },
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.settings,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "О приложении (F2)",
                child: ElevatedButton(
                  onPressed: () {
                    //Вызов нового окна поверх.
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutPanel()));
                  },
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.happy,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Справочка (F1)",
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Reference()));
                  },
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.help,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                ),
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Сохранить ленты (Crtl+Shift+S)",
                child: ElevatedButton(
                  onPressed: () {
                    machine.saveLinesJson = jsonEncode(machine.linesToJson());
                  },
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.save,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Загрузить ленты (Crtl+Shift+L)",
                child: ElevatedButton(
                  onPressed: () {
                    if (machine.saveLinesJson != null) {
                      machine.importLinesJson(machine.saveLinesJson!);
                      linePagesState.currentState!.setState(() {});
                      var count = machine.model.countOfLines;
                      if (count != machine.configuration.linePointers.length) {
                        for (int i = 0; i < (count - machine.configuration.linePointers.length).abs(); i++) {
                          count < machine.configuration.linePointers.length
                              ? {machine.model.addLine(), tableState.currentState!.addLine()}
                              : {machine.model.deleteLine(), tableState.currentState!.deleteLine()};
                        }
                      }
                    }
                  },
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.load,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Очистить ленты (Crtl+Shift+C)",
                child: ElevatedButton(
                  onPressed: () {
                    linePagesState.currentState!.clearAllLines();
                  },
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.clear,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Container(
                width: 2,
                color: AppColors.highlight,
                height: 16,
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Добавить ленту (Crtl+Shift+])",
                child: ElevatedButton(
                  onPressed: () {
                    if (machine.addLine()) {
                      linePagesState.currentState?.setState(() {});
                      tableState.currentState!.addLine();
                    }
                  },
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.addVariantDown,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Удалить ленту (Crtl+Shift+[)",
                child: ElevatedButton(
                  onPressed: () {
                    if (machine.deleteLine()) {
                      linePagesState.currentState?.setState(() {});
                      tableState.currentState!.deleteLine();
                    }
                  },
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.deleteVariant,
                    ),
                  ),
                  style: appButtonStyle,
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 2,
          thickness: 2,
          color: AppColors.highlight,
        ),
      ],
    );
  }
}
