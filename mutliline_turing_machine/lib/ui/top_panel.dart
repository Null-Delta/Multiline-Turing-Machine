import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:mutliline_turing_machine/ui/about_panel.dart';
import 'package:mutliline_turing_machine/ui/custom_popup.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:mutliline_turing_machine/ui/referance.dart';
import 'package:mutliline_turing_machine/ui/settings_panel.dart';
import 'package:provider/provider.dart';

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

  @override
  Widget build(BuildContext context) {
    var machine = MachineInherit.of(context)!.machine;
    var tableState = MachineInherit.of(context)!.tableState;
    var linePagesState = MachineInherit.of(context)!.linesPageState;
    var bottomSplitState = MachineInherit.of(context)!.bottomSplitState;
    var statesListState = MachineInherit.of(context)!.statesListState;
    var animationState = MachineInherit.of(context)!.animationState;

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
                        child: Text(
                          "Новый файл",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).cardColor,
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
                          "Загрузить",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).cardColor,
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
                          "Сохранить как",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).cardColor,
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
                  child: Image(image: AppImages.file, color: Theme.of(context).cardColor)),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Настройки",
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return ChangeNotifierProvider.value(
                        value: animationState,
                        child: const SettingsPanel(),
                      );
                    }));
                  },
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
                message: "О приложении",
                child: ElevatedButton(
                  onPressed: () {
                    //Вызов нового окна поверх.
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const AboutPanel()));
                  },
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(image: AppImages.happy, color: Theme.of(context).cardColor),
                  ),
                  style: appButtonStyle(context),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Справочка",
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Reference()));
                  },
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(image: AppImages.help, color: Theme.of(context).cardColor),
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
                message: "Сохранить ленты",
                child: ElevatedButton(
                  onPressed: () {
                    machine.saveLinesJson = jsonEncode(machine.linesToJson());
                  },
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(image: AppImages.save, color: Theme.of(context).cardColor),
                  ),
                  style: appButtonStyle(context),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Загрузить ленты",
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
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(image: AppImages.load, color: Theme.of(context).cardColor),
                  ),
                  style: appButtonStyle(context),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Очистить ленты",
                child: ElevatedButton(
                  onPressed: () {
                    linePagesState.currentState!.clearAllLines();
                  },
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(image: AppImages.clear, color: Theme.of(context).cardColor),
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
                message: "Добавить ленту",
                child: ElevatedButton(
                  onPressed: () {
                    if (machine.addLine()) {
                      linePagesState.currentState?.setState(() {});
                      tableState.currentState!.addLine();
                    }
                  },
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(image: AppImages.addVariantDown, color: Theme.of(context).cardColor),
                  ),
                  style: appButtonStyle(context),
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Удалить ленту",
                child: ElevatedButton(
                  onPressed: () {
                    if (machine.deleteLine()) {
                      linePagesState.currentState?.setState(() {});
                      tableState.currentState!.deleteLine();
                    }
                  },
                  child: SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(image: AppImages.deleteVariant, color: Theme.of(context).cardColor),
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
