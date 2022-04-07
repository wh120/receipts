import 'package:flutter/material.dart';

class WidgetDataTable extends StatelessWidget {

  final List<Widget> columns;
  final List<List<Widget>> rows;


  const WidgetDataTable({Key key, this.columns, this.rows}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(

          columns: List.generate(columns.length, (index) => DataColumn(
            label: columns[index],
          ),),
          rows: List.generate(rows.length, (index) => DataRow(
            cells: List.generate(columns.length, (i) {
              Widget text = i >= rows[index].length ?Text('-'): rows[index][i];
              return DataCell(text);
            }),
          )),
        ),
      ),
    );
  }
}

