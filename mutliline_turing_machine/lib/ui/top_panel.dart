import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:mutliline_turing_machine/ui/about_panel.dart';
import 'package:mutliline_turing_machine/ui/custom_popup.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:mutliline_turing_machine/ui/referance.dart';
import 'package:mutliline_turing_machine/ui/turing_machine_table.dart';
import '../styles/app_colors.dart';
import 'lines_page.dart';

// ignore: must_be_immutable
class TopPanel extends StatefulWidget {
  TopPanel({
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
    //TODO: исправить, чтобы таблицу не пересобирал
    var bottomSplitState = MachineInherit.of(context)!.bottomSplitState;
    var statesListState = MachineInherit.of(context)!.statesListState;
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
                          onTap: () {
                            var emptyMachine = TuringMachine(TuringMachineModel());

                            machine.loadFromJson(jsonDecode(jsonEncode(emptyMachine.toJson())));
                            tableState.currentState!.reloadTable();
                            statesListState.currentState!.setState(() {});
                            linePagesState.currentState!.setState(() {});
                            bottomSplitState.currentState!.setState(() {});
                          },
                          height: 32,
                          child: Text(
                            "Новая машина",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.text,
                            ),
                          )),
                      PopupMenuItem(
                          height: 32,
                          child: Text(
                            "Сохранить машину",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.text,
                            ),
                          )),
                      PopupMenuItem(
                          height: 32,
                          child: Text(
                            "Загрузить машину",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.text,
                            ),
                          )),
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
                message: "Настройки",
                child: ElevatedButton(
                  onPressed: () {
                    if (machine.saveMachineJson != null) {
                      machine.loadFromJson(jsonDecode(machine.saveMachineJson!));
                      tableState.currentState!.reloadTable();
                      statesListState.currentState!.setState(() {});
                      linePagesState.currentState!.setState(() {});
                      bottomSplitState.currentState!.setState(() {});
                    }
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
                message: "О приложении",
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
                message: "Справочка",
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
                message: "Сохранить ленты",
                child: ElevatedButton(
                  onPressed: () {
                    machine.saveLinesJson = machine.linesToJson().toString();
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
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.update,
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
                message: "Очистить ленты",
                child: ElevatedButton(
                  onPressed: () {},
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
                message: "Добавить ленту",
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
                      image: AppImages.addVariantTop,
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
                message: "Удалить ленту",
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
