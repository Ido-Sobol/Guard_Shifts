import 'package:flutter/material.dart';
import 'package:shidts/guard.dart';
import 'package:shidts/areas.dart';

class Shift {
  final String date;
  final Guard? evening1;
  final Guard? evening2;
  final Guard? night1;
  final Guard? night2;
  final Areas area;
  final int id;
  Shift(this.date, this.evening1, this.evening2, this.night1, this.night2,
      this.area, this.id);
}

enum GuardType {
  evening1("guard_1_evening"),
  evening2("guard_2_evening"),
  night1("guard_1_night"),
  night2("guard_2_night");

  const GuardType(this.hasuraName);

  final String hasuraName;
}

DataRow getRow(
        final Shift shift, final void Function(GuardType, Guard?) onClick) =>
    DataRow(cells: [
      DataCell(Text(shift.date)),
      DataCell(Text(
        shift.area.message,
        textDirection: TextDirection.rtl,
      )),
      DataCell(
        Text(shift.evening1?.name ?? ""),
        onTap: () => onClick(GuardType.evening1, shift.evening1),
      ),
      DataCell(
        Text(shift.evening2?.name ?? ""),
        onTap: () => onClick(GuardType.evening2, shift.evening2),
      ),
      DataCell(
        Text(shift.night1?.name ?? ""),
        onTap: () => onClick(GuardType.night1, shift.night1),
      ),
      DataCell(
        Text(shift.night2?.name ?? ""),
        onTap: () => onClick(GuardType.night2, shift.night2),
      ),
    ]);
