import 'package:flutter/material.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'package:mutliline_turing_machine/ui/machine_inherit.dart';
import '../model/turing_machine.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import '../styles/table_configuration.dart';
import 'dart:developer' as developer;

class TuringMachineTable extends StatefulWidget {
  const TuringMachineTable(
      {Key? key,
      required this.onLoaded,
      this.topFocus,
      this.rightFocus,
      this.leftFocus})
      : super(key: key);

  final void Function(PlutoGridStateManager manager) onLoaded;

  final FocusNode? topFocus;
  final FocusNode? rightFocus;
  final FocusNode? leftFocus;

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
  List<int>? dragRows;

  bool needInit = true;

  late PlutoGridStateManager stateManager;

  void onStateUpdate() {
    if (stateManager.isDraggingRow) {
      draggingIndex ??= stateManager.dragTargetRowIdx;
      dragRows = stateManager.dragRows.map((e) => rows.indexOf(e)).toList();
    } else {
      if (stateManager.currentCell != null) {
        selectedRow = rows.indexOf(stateManager.currentCell!.row);
        selectedColumn = columns.indexOf(stateManager.currentCell!.column);
      }
    }
  }

  void addVariant() {
    int rowIndex = selectedRow == -1
        ? machine.model.stateList[machine.configuration.currentStateIndex]
            .countOfVariants
        : selectedRow + 1;

    machine.model.addVariant(machine.configuration.currentStateIndex, rowIndex);

    var row = PlutoRow(
      cells: {
        for (int i = 0; i < machine.model.countOfLines + 2; i++)
          i == machine.model.countOfLines + 1 ? "translate" : "head:$i":
              PlutoCell(
                  value: i == 0
                      ? "№ ${rowIndex + 1}"
                      : i == machine.model.countOfLines + 1
                          ? "${machine.model.stateList[machine.configuration.currentStateIndex].ruleList[rowIndex].toState + 1}"
                          : machine
                              .model
                              .stateList[
                                  machine.configuration.currentStateIndex]
                              .ruleList[rowIndex]
                              .commandList[i - 1]
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
    machine.model
        .deleteVariant(machine.configuration.currentStateIndex, rowIndex - 1);

    stateManager.removeRows([rows[rowIndex - 1]]);

    if (selectedRow == -1) {
      selectedRow = machine.currentState.countOfVariants - 1;
    }
    if (selectedRow == rows.length) {
      selectedRow -= 1;
    }

    for (int i = selectedRow; i < machine.currentState.countOfVariants; i++) {
      stateManager.changeCellValue(rows[i].cells["head:0"]!, "№ ${i + 1}",
          force: true, notify: true);
    }

    rows[selectedRow].setState(PlutoRowState.updated);

    if (selectedColumn == -1) {
      selectedColumn = 1;
    }

    selectedColumn == machine.model.countOfLines + 1
        ? stateManager.setCurrentCell(
            rows[selectedRow].cells["translate"]!, selectedRow)
        : stateManager.setCurrentCell(
            rows[selectedRow].cells["head:$selectedColumn"]!, selectedRow);
  }

  void addLine() {
    var column = PlutoColumn(
      backgroundColor: Colors.transparent,
      cellPadding: 6,
      readOnly: false,
      frozen: PlutoColumnFrozen.none,
      enableContextMenu: false,
      enableSorting: false,
      enableRowDrag: false,
      enableColumnDrag: false,
      enableEditingMode: true,
      enableAutoEditing: false,
      textAlign: PlutoColumnTextAlign.center,
      titleTextAlign: PlutoColumnTextAlign.center,
      width: 84,
      minWidth: 64,
      title: "Лента ${machine.model.countOfLines}",
      field: "head:${machine.model.countOfLines}",
      type: PlutoColumnType.text(),
    );

    stateManager.insertColumns(machine.model.countOfLines, [column]);

    for (int i = 0; i < machine.currentState.countOfVariants; i++) {
      stateManager.changeCellValue(
          rows[i].cells["head:${machine.model.countOfLines}"]!, "* * _");
    }
  }

  void deleteLine() {
    stateManager.removeColumns([columns[columns.length - 2]]);
  }

  void updateTableState() {
    stateManager.removeRows(rows);
    stateManager.clearCurrentCell();
    selectedColumn = -1;
    selectedRow = -1;

    //developer.log("count ${machine.model.stateList[machine.configuration.currentStateIndex].countOfVariants}");

    List<PlutoRow> newRows = [];

    for (int i = 0;
        i <
            machine.model.stateList[machine.configuration.currentStateIndex]
                .countOfVariants;
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
                              ? "${machine.model.stateList[machine.configuration.currentStateIndex].ruleList[i].toState + 1}"
                              : machine
                                  .model
                                  .stateList[
                                      machine.configuration.currentStateIndex]
                                  .ruleList[i]
                                  .commandList[j - 1]
                                  .toString())
          },
        ),
      );
    }

    stateManager.appendRows(newRows);
  }

  void reloadTable() {
    selectedRow = -1;
    selectedColumn = -1;
    stateManager.removeRows(rows);
    stateManager.removeColumns(columns);

    List<PlutoColumn> newColumns = [];
    List<PlutoRow> newRows = [];

    developer.log("count is ${machine.model.countOfLines}");
    for (int i = 0; i < machine.model.countOfLines + 2; i++) {
      newColumns.add(
        PlutoColumn(
          backgroundColor: Colors.transparent,
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
              ? "Команды"
              : i == machine.model.countOfLines + 1
                  ? "Переход"
                  : "Лента $i",
          field: i == machine.model.countOfLines + 1 ? "translate" : "head:$i",
          type: PlutoColumnType.text(),
        ),
      );
    }

    for (int i = 0;
        i <
            machine.model.stateList[machine.configuration.currentStateIndex]
                .countOfVariants;
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
                              ? "${machine.model.stateList[machine.configuration.currentStateIndex].ruleList[i].toState + 1}"
                              : machine
                                  .model
                                  .stateList[
                                      machine.configuration.currentStateIndex]
                                  .ruleList[i]
                                  .commandList[j - 1]
                                  .toString())
          },
        ),
      );
    }

    //stateManager.columns/
    //stateManager.insertColumns(0, newColumns);
    stateManager.insertColumns(0, newColumns);
    stateManager.appendRows(newRows);
  }

  void initTable() {
    columns.clear();
    rows.clear();

    for (int i = 0; i < machine.model.countOfLines + 2; i++) {
      columns.add(
        PlutoColumn(
          backgroundColor: Colors.transparent,
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
              ? "Команды"
              : i == machine.model.countOfLines + 1
                  ? "Переход"
                  : "Лента $i",
          field: i == machine.model.countOfLines + 1 ? "translate" : "head:$i",
          type: PlutoColumnType.text(),
        ),
      );
    }

    for (int i = 0;
        i <
            machine.model.stateList[machine.configuration.currentStateIndex]
                .countOfVariants;
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
                              ? "${machine.model.stateList[machine.configuration.currentStateIndex].ruleList[i].toState + 1}"
                              : machine
                                  .model
                                  .stateList[
                                      machine.configuration.currentStateIndex]
                                  .ruleList[i]
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
    if (needInit) {
      initTable();
      needInit = false;
    }

    return Container(
      color: Theme.of(context).colorScheme.background,
      child: PlutoGrid(
        rows: rows,
        leftFocus: widget.leftFocus,
        columns: columns,
        topFocus: widget.topFocus,
        rightFocus: widget.rightFocus,
        onChanged: (event) {
          if (event.columnIdx == null || event.rowIdx == null) return;
          if (event.columnIdx == -1 || event.rowIdx == -1) return;

          if (event.columnIdx! != columns.length - 1) {
            var command = TuringCommand.parse(event.value);
            if (command == null) {
              stateManager.changeCellValue(
                  event.row!.cells["head:${event.columnIdx}"]!, event.oldValue,
                  callOnChangedEvent: false);
            } else {
              machine.model.setComandInVariant(
                  machine.configuration.currentStateIndex,
                  event.rowIdx!,
                  event.columnIdx! - 1,
                  command);
              stateManager.changeCellValue(
                  event.row!.cells["head:${event.columnIdx}"]!,
                  command.toString(),
                  callOnChangedEvent: false);
            }
          } else {
            var num = int.tryParse(event.value);
            if (num != null && num >= 0) {
              machine.model.setToStateInVariant(
                  machine.configuration.currentStateIndex,
                  event.rowIdx!,
                  num - 1);
            } else {
              stateManager.changeCellValue(
                  event.row!.cells["translate"]!, event.oldValue,
                  callOnChangedEvent: false);
            }
          }
        },
        onRowsMoved: (event) {
          developer.log("${event.idx}");

          machine.model.replaceVariants(
              machine.configuration.currentStateIndex, dragRows!, event.idx!);

          draggingIndex = null;
          dragRows = null;

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
        configuration: getConfig(context),
      ),
    );
  }
}
