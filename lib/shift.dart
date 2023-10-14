import 'package:flutter/material.dart';
import 'package:shidts/areas.dart';
import 'package:shidts/guardPair.dart';

class Shift{
  final String date;
  final GuardPair pair;
  final Areas area;
  Shift(this.date, this.pair, this.area);

  DataRow getData() {
    return DataRow(cells: [
                  DataCell(Text('2023-10-14')),
                  DataCell(Text(Areas.EAST.message)),
                  DataCell(GuardPair(const ['John', 'Alice'])),
                  DataCell(GuardPair(const ['Bob', 'Eve'])),
                ]);
  }
  

}