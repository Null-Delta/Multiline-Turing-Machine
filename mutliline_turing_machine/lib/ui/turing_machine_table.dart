import 'package:flutter/material.dart';
import 'package:multi_split_view/multi_split_view.dart';
import 'package:mutliline_turing_machine/model/turing_machine_model.dart';
import 'package:mutliline_turing_machine/ui/state_comments.dart';
import '../model/turing_machine.dart';
import '../styles/app_colors.dart';
import 'package:mutliline_turing_machine/table/lib/pluto_grid.dart';
import '../styles/table_configuration.dart';
import 'dart:developer' as developer;

// ignore: must_be_immutable
class TuringMachineTable extends StatefulWidget {
  TuringMachineTable({Key? key, required this.machine, required this.onLoaded})
      : super(key: key);

  final TuringMachine machine;

  late int Function() selectedRow;
  late int Function() selectedColumn;
  late void Function() addVariant;
  late void Function() deleteVariant;

  final void Function(PlutoGridStateManager manager) onLoaded;

  @override
  State<TuringMachineTable> createState() => _TuringMachineTableState();
}

class _TuringMachineTableState extends State<TuringMachineTable> {
  List<PlutoRow> rows = [];
  List<PlutoColumn> columns = [];

  int selectedRow = -1;
  int selectedColumn = -1;

  late PlutoGridStateManager stateManager;

  void onStateUpdate() {
    if (stateManager.currentCell != null) {
      selectedRow = rows.indexOf(stateManager.currentCell!.row);
      selectedColumn = columns.indexOf(stateManager.currentCell!.column);
    }
  }

  void addVariant() {
    widget.machine.model.addVariant(widget.machine.currentStateIndex);
    int rowIndex = selectedRow == -1
        ? widget.machine.model.stateList[widget.machine.currentStateIndex]
                .countOfVariants -
            1
        : selectedRow + 1;

    var row = PlutoRow(
      cells: {
        for (int i = 0; i < widget.machine.model.countOfLines + 2; i++)
          "head:$i": PlutoCell(value: i == 0 ? "№ ${rowIndex + 1}" : "_ _ _")
      },
    );

    stateManager.insertRows(
      rowIndex,
      [row],
    );

    for (int i = rowIndex + 1;
        i < widget.machine.currentState.countOfVariants;
        i++) {
      stateManager.changeCellValue(rows[i].cells["head:0"]!, "№ ${i + 1}",
          force: true, notify: true);
    }

    selectedRow = rowIndex;
    if (selectedColumn == -1) {
      selectedColumn = 1;
    }

    stateManager.setCurrentCell(
        rows[selectedRow].cells["head:$selectedColumn"]!, selectedRow);
  }

  void deleteVariant() {
    if (widget.machine.currentState.countOfVariants == 1) {
      return;
    }
    int rowIndex = selectedRow == -1
        ? widget.machine.currentState.countOfVariants - 1
        : selectedRow + 1;

    developer.log("$rowIndex");
    widget.machine.model
        .deleteVariant(widget.machine.currentStateIndex, rowIndex - 1);

    stateManager.removeRows([rows[rowIndex - 1]]);

    if (selectedRow == rows.length) {
      selectedRow -= 1;
    }

    for (int i = selectedRow;
        i < widget.machine.currentState.countOfVariants;
        i++) {
      stateManager.changeCellValue(rows[i].cells["head:0"]!, "№ ${i + 1}",
          force: true, notify: true);
    }

    rows[selectedRow].setState(PlutoRowState.updated);

    stateManager.setCurrentCell(
        rows[selectedRow].cells["head:$selectedColumn"]!, selectedRow);
  }

  @override
  void initState() {
    widget.selectedRow = () {
      return selectedRow;
    };

    widget.selectedColumn = () {
      return selectedColumn;
    };

    widget.addVariant = addVariant;
    widget.deleteVariant = deleteVariant;

    super.initState();
    for (int i = 0; i < widget.machine.model.countOfLines + 2; i++) {
      columns.add(
        PlutoColumn(
          backgroundColor: AppColors.background,
          cellPadding: 0,
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
              : i == widget.machine.model.countOfLines + 1
                  ? "Переход"
                  : "Лента $i",
          field: "head:$i",
          type: PlutoColumnType.text(),
        ),
      );
    }

    for (int i = 0;
        i <
            widget.machine.model.stateList[widget.machine.currentStateIndex]
                .countOfVariants;
        i++) {
      rows.add(
        PlutoRow(
          cells: {
            for (int j = 0; j < widget.machine.model.countOfLines + 2; j++)
              "head:$j": PlutoCell(
                  value: j == 0
                      ? "№ ${i + 1}"
                      : j == widget.machine.model.countOfLines + 2
                          ? "_"
                          : "_ _ _")
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 84,
            color: AppColors.background,
            child: Column(
              children: [
                SizedBox(
                  height: 34,
                  child: Center(
                    child: Text(
                      "Состояния",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                  ),
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                  color: AppColors.highlight,
                ),
              ],
            ),
          ),
          Container(
            width: 2,
            color: AppColors.highlight,
          ),
          Expanded(
            child: MultiSplitViewTheme(
              data: MultiSplitViewThemeData(
                dividerThickness: 2,
                dividerPainter: DividerPainter(
                  backgroundColor: AppColors.highlight,
                ),
              ),
              child: MultiSplitView(
                antiAliasingWorkaround: false,
                axis: Axis.horizontal,
                resizable: true,
                minimalSize: 256,
                initialWeights: const [0.7, 0.3],
                children: [
                  PlutoGrid(
                    rows: rows,
                    columns: columns,
                    onChanged: (event) {
                      if (event.columnIdx! != columns.length - 1) {
                        var command = TuringCommand.parse(event.value);
                        if (command == null) {
                          stateManager.changeCellValue(
                              event.row!.cells["head:${event.columnIdx}"]!,
                              event.oldValue);
                        } else {
                          widget.machine.model.setComandInVariant(
                              widget.machine.currentStateIndex,
                              event.rowIdx!,
                              event.columnIdx! - 1,
                              command);
                          stateManager.changeCellValue(
                              event.row!.cells["head:${event.columnIdx}"]!,
                              command.toString());
                        }
                      } else {
                        //TODO: изменение перехода
                      }
                    },
                    onRowsMoved: (event) {
                      //TODO: обработка перемещения конфигурации
                      //developer.log("${event.idx}");
                      //developer.log("${event.rows![0].}");
                    },
                    onSelected: (event) {},
                    onLoaded: (event) {
                      stateManager = event.stateManager;
                      event.stateManager
                          .setSelectingMode(PlutoGridSelectingMode.row);
                      widget.onLoaded(event.stateManager);
                      event.stateManager.addListener(onStateUpdate);
                    },
                    configuration: tableConfiguration,
                  ),
                  const StateComments(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
