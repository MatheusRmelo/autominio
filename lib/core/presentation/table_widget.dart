import 'package:flutter/material.dart';

class TableWidget<T> extends StatelessWidget {
  const TableWidget(
      {super.key,
      this.hasAction = false,
      this.onEdit,
      this.onDelete,
      required this.parser,
      required this.columns,
      required this.data});
  final bool hasAction;
  final List<TableOptionModel> columns;
  final List<T> data;
  final List<TableOptionModel> Function(T element) parser;
  final void Function(int index)? onEdit;
  final void Function(int index)? onDelete;

  List<DataColumn> get columnsTable {
    List<DataColumn> result = columns
        .map((element) =>
            DataColumn(label: element.customWidget ?? Text(element.name)))
        .toList();
    if (hasAction) {
      result.add(const DataColumn(
        numeric: true,
        label: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Ações',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ));
    }
    return result;
  }

  List<DataRow> get rowsTable {
    List<DataRow> result = [];
    for (int index = 0; index < data.length; index++) {
      List<DataCell> cells = parser(data[index])
          .map(
              (element) => DataCell(element.customWidget ?? Text(element.name)))
          .toList();
      if (hasAction) {
        cells.add(DataCell(
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            if (onEdit != null)
              InkWell(
                  child: const Icon(Icons.edit),
                  onTap: () {
                    onEdit!(index);
                  }),
            const SizedBox(
              width: 8,
            ),
            if (onDelete != null)
              InkWell(
                  child: const Icon(Icons.delete),
                  onTap: () {
                    onDelete!(index);
                  }),
          ]),
        ));
      }
      result.add(DataRow(cells: cells));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: columnsTable,
      rows: rowsTable,
    );
  }
}

class TableOptionModel {
  final String name;
  final Widget? customWidget;

  TableOptionModel({required this.name, this.customWidget});
}
