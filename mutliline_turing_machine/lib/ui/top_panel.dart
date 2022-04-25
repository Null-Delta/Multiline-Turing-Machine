import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine.dart';
import 'package:mutliline_turing_machine/styles/app_button.dart';
import 'package:mutliline_turing_machine/styles/app_images.dart';
import 'package:mutliline_turing_machine/ui/about_panel.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import 'package:mutliline_turing_machine/ui/referance.dart';
import 'package:mutliline_turing_machine/ui/turing_machine_table.dart';
import '../styles/app_colors.dart';
import 'lines_page.dart';

// ignore: must_be_immutable
class TopPanel extends StatefulWidget {
  TopPanel({
    required this.importFile,
    Key? key,
  }) : super(key: key);

  void Function(String) importFile;

  @override
  State<TopPanel> createState() => _TopPanelState();
}

class _TopPanelState extends State<TopPanel> {
  static const double iconSize = 28;

  late var json;

  @override
  Widget build(BuildContext context) {
    var machine = MachineInherit.of(context)!.machine;
    var tableState = MachineInherit.of(context)!.tableState;
    var linePagesState = MachineInherit.of(context)!.linesPageState;
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
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Файл",
                child: ElevatedButton(
                  onPressed: () {},
                  child: const SizedBox(
                    width: iconSize,
                    height: iconSize,
                    child: Image(
                      image: AppImages.file,
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
                message: "Настройки",
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      json = machine.toJson().toString();
                    });
                    log(json.toString());
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AboutPanel()));
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Reference()));
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
                      image: AppImages.addVariantTop,
                    ),
                  ),
                  style: appButtonStyle,
                ),
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
                        log("ОШО2");

                        for (int i = 0;
                            i <
                                (count -
                                        machine
                                            .configuration.linePointers.length)
                                    .abs();
                            i++) {
                          count < machine.configuration.linePointers.length
                              ? {
                                  machine.model.addLine(),
                                  tableState.currentState!.addLine()
                                }
                              : {
                                  machine.model.deleteLine(),
                                  tableState.currentState!.deleteLine()
                                };
                        }
                      }
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
              Tooltip(
                waitDuration: const Duration(milliseconds: 500),
                message: "Очистить ленты",
                child: ElevatedButton(
                  onPressed: () {},
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
