import 'package:flutter/material.dart';

class MyDataTable extends StatelessWidget {

  final List<String> columns;
  final List<List<String>> rows;


  const MyDataTable({Key key, this.columns, this.rows}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(

          columns: List.generate(columns.length, (index) => DataColumn(
            label: Text(
              columns[index],
            ),
          ),),
          rows: List.generate(rows.length, (index) => DataRow(
            cells: List.generate(rows[index].length, (i) => DataCell(Text(rows[index][i]))),
          )),
        ),
      ),
    );
  }
}

