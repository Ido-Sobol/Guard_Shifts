import 'package:flutter/material.dart';
import 'package:shidts/areas.dart';
import 'package:shidts/guardPair.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Guard Table'),
        ),
        body: GuardTable(),
      ),
    );
  }
}

class GuardTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Area')),
                DataColumn(label: Text('21:00 - 01:00')),
                DataColumn(label: Text('01:00 - 05:00')),
              ],
              rows: [
                DataRow(cells: [
                  DataCell(Text('2023-10-14')),
                  DataCell(Text(Areas.EAST.message)),
                  DataCell(GuardPair(const ['John', 'Alice'])),
                  DataCell(GuardPair(const ['Bob', 'Eve'])),
                ]),
                DataRow(cells: [
                  DataCell(Text('2023-10-15')),
                  DataCell(Text(Areas.WEST1.message)),
                  DataCell(GuardPair(const ['Charlie', 'Dave'])),
                  DataCell(GuardPair(const ['Frank', 'Grace'])),
                ]),
                DataRow(cells: [
                  DataCell(Text('2023-10-15')),
                  DataCell(Text(Areas.WEST2.message)),
                  DataCell(GuardPair(const ['Charlie', 'Dave'])),
                  DataCell(GuardPair(const ['Frank', 'Grace'])),
                ]),
                // Add more rows as needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
