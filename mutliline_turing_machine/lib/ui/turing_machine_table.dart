import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import '../model/turing_machine.dart';
import '../styles/app_colors.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import '../styles/table_configuration.dart';
import 'dart:developer' as developer;

class TuringMachineTable extends StatefulWidget {
  const TuringMachineTable({Key? key, required this.onLoaded})
      : super(key: key);

  final void Function(PlutoGridStateManager manager) onLoaded;

  @override
  TuringMachineTableState createState() => TuringMachineTableState();
}

class TuringMachineTableState extends State<TuringMachineTable> {
  late TuringMachine machine;

  List<PlutoRow> rows = [];
  List<PlutoColumn> columns = [];

  int selectedRow = -1;
  int selectedColumn = -1;
  int? draggingIndex;

  late PlutoGridStateManager stateManager;

  void onStateUpdate() {
    if (stateManager.isDraggingRow) {
      draggingIndex ??= stateManager.dragTargetRowIdx;
    } else {
      if (stateManager.currentCell != null) {
        selectedRow = rows.indexOf(stateManager.currentCell!.row);
        selectedColumn = columns.indexOf(stateManager.currentCell!.column);
      }
    }
  }

  void addVariant() {
    int rowIndex = selectedRow == -1
        ? machine.model.stateList[machine.currentStateIndex].countOfVariants
        : selectedRow + 1;

    machine.model.addVariant(machine.currentStateIndex, rowIndex);

    var row = PlutoRow(
      cells: {
        for (int i = 0; i < machine.model.countOfLines + 2; i++)
          i == machine.model.countOfLines + 1 ? "translate" : "head:$i":
              PlutoCell(
                  value: i == 0
                      ? "№ ${rowIndex + 1}"
                      : i == machine.model.countOfLines + 1
                          ? "${machine.model.stateList[machine.currentStateIndex].variantList[rowIndex].toState}"
                          : machine.model.stateList[machine.currentStateIndex]
                              .variantList[rowIndex].commandList[i - 1]
                              .toString())
      },
    );

    stateManager.insertRows(
      rowIndex,
      [row],
    );

    for (int i = rowIndex + 1; i < machine.currentState.countOfVariants; i++) {
      stateManager.changeCellValue(rows[i].cells["head:0"]!, "№ ${i + 1}",
          force: true, notify: true);
    }

    selectedRow = rowIndex;
    if (selectedColumn == -1) {
      selectedColumn = 1;
    }

    selectedColumn == machine.model.countOfLines + 1
        ? stateManager.setCurrentCell(
            rows[selectedRow].cells["translate"]!, selectedRow)
        : stateManager.setCurrentCell(
            rows[selectedRow].cells["head:$selectedColumn"]!, selectedRow);
  }

  void deleteVariant() {
    if (machine.currentState.countOfVariants == 1) {
      return;
    }
    int rowIndex = selectedRow == -1
        ? machine.currentState.countOfVariants - 1
        : selectedRow + 1;

    developer.log("$rowIndex");
    machine.model.deleteVariant(machine.currentStateIndex, rowIndex - 1);

    stateManager.removeRows([rows[rowIndex - 1]]);

    if (selectedRow == rows.length) {
      selectedRow -= 1;
    }

    for (int i = selectedRow; i < machine.currentState.countOfVariants; i++) {
      stateManager.changeCellValue(rows[i].cells["head:0"]!, "№ ${i + 1}",
          force: true, notify: true);
    }

    rows[selectedRow].setState(PlutoRowState.updated);

    selectedColumn == machine.model.countOfLines + 1
        ? stateManager.setCurrentCell(
            rows[selectedRow].cells["translate"]!, selectedRow)
        : stateManager.setCurrentCell(
            rows[selectedRow].cells["head:$selectedColumn"]!, selectedRow);
  }

  @override
  void initState() {
    super.initState();

    //machine = MachineInherit.of(context)!.machine;

    // initTable();
  }

  void updateTableState() {
    stateManager.removeRows(rows);
    stateManager.clearCurrentCell();
    selectedColumn = -1;
    selectedRow = -1;

    developer.log(
        "${machine.model.stateList[machine.currentStateIndex].countOfVariants}");

    List<PlutoRow> newRows = [];

    for (int i = 0;
        i < machine.model.stateList[machine.currentStateIndex].countOfVariants;
        i++) {
      newRows.add(
        PlutoRow(
          cells: {
            for (int j = 0; j < machine.model.countOfLines + 2; j++)
              j == machine.model.countOfLines + 1 ? "translate" : "head:$j":
                  PlutoCell(
                      value: j == 0
                          ? "№ ${i + 1}"
                          : j == machine.model.countOfLines + 1
                              ? "${machine.model.stateList[machine.currentStateIndex].variantList[i].toState}"
                              : machine
                                  .model
                                  .stateList[machine.currentStateIndex]
                                  .variantList[i]
                                  .commandList[j - 1]
                                  .toString())
          },
        ),
      );
    }

    stateManager.appendRows(newRows);
  }

  void initTable() {
    columns.clear();
    rows.clear();
    developer.log("${machine.currentStateIndex}");

    for (int i = 0; i < machine.model.countOfLines + 2; i++) {
      columns.add(
        PlutoColumn(
          backgroundColor: AppColors.background,
          cellPadding: 6,
          readOnly: i == 0,
          frozen: i == 0 ? PlutoColumnFrozen.left : PlutoColumnFrozen.none,
          enableContextMenu: false,
          enableSorting: false,
          enableRowDrag: i == 0 ? true : false,
          enableColumnDrag: false,
          enableEditingMode: i != 0,
          enableAutoEditing: false,
          textAlign: PlutoColumnTextAlign.center,
          titleTextAlign: PlutoColumnTextAlign.center,
          width: 84,
          minWidth: 64,
          title: i == 0
              ? "Варианты"
              : i == machine.model.countOfLines + 1
                  ? "Переход"
                  : "Лента $i",
          field: i == machine.model.countOfLines + 1 ? "translate" : "head:$i",
          type: PlutoColumnType.text(),
        ),
      );
    }

    for (int i = 0;
        i < machine.model.stateList[machine.currentStateIndex].countOfVariants;
        i++) {
      rows.add(
        PlutoRow(
          cells: {
            for (int j = 0; j < machine.model.countOfLines + 2; j++)
              j == machine.model.countOfLines + 1 ? "translate" : "head:$j":
                  PlutoCell(
                      value: j == 0
                          ? "№ ${i + 1}"
                          : j == machine.model.countOfLines + 1
                              ? "${machine.model.stateList[machine.currentStateIndex].variantList[i].toState}"
                              : machine
                                  .model
                                  .stateList[machine.currentStateIndex]
                                  .variantList[i]
                                  .commandList[j - 1]
                                  .toString())
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    developer.log("rebuild table");
    machine = MachineInherit.of(context)!.machine;
    initTable();

    return PlutoGrid(
      rows: rows,
      columns: columns,
      onChanged: (event) {
        if (event.columnIdx! != columns.length - 1) {
          var command = TuringCommand.parse(event.value);
          if (command == null) {
            stateManager.changeCellValue(
                event.row!.cells["head:${event.columnIdx}"]!, event.oldValue,
                callOnChangedEvent: false);
          } else {
            machine.model.setComandInVariant(machine.currentStateIndex,
                event.rowIdx!, event.columnIdx! - 1, command);
            stateManager.changeCellValue(
                event.row!.cells["head:${event.columnIdx}"]!,
                command.toString(),
                callOnChangedEvent: false);
          }
        } else {
          var num = int.tryParse(event.value);
          if (num != null && num >= 0) {
            machine.model.setToStateInVariant(
                machine.currentStateIndex, event.rowIdx!, num);
          } else {
            stateManager.changeCellValue(
                event.row!.cells["translate"]!, event.oldValue,
                callOnChangedEvent: false);
          }
        }
      },
      onRowsMoved: (event) {
        machine.model.replaceVariants(
            machine.currentStateIndex, draggingIndex!, event.idx!);
        draggingIndex = null;

        for (int i = 0; i < machine.currentState.countOfVariants; i++) {
          stateManager.changeCellValue(rows[i].cells["head:0"]!, "№ ${i + 1}",
              force: true, notify: true);
        }
      },
      onLoaded: (event) {
        stateManager = event.stateManager;
        event.stateManager.setSelectingMode(PlutoGridSelectingMode.row);
        widget.onLoaded(event.stateManager);
        event.stateManager.addListener(onStateUpdate);
      },
      configuration: tableConfiguration,
    );
  }
}
