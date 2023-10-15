import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shidts/constants.dart';
import 'package:shidts/firebase_options.dart';
import 'package:shidts/login_screen.dart';
import 'package:shidts/shift.dart';
import 'package:shidts/update_shift.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      theme: darkModeTheme,
    );
  }
}

class GuardTable extends StatelessWidget {
  const GuardTable(this.shifts, this.authKey, {super.key});
  final List<Shift> shifts;
  final String authKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: DataTable(
              columns: const [
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Area')),
                DataColumn(label: Text('21:00 - 01:00')),
                DataColumn(label: Text('21:00 - 01:00')),
                DataColumn(label: Text('01:00 - 05:00')),
                DataColumn(label: Text('01:00 - 05:00')),
              ],
              rows: shifts
                  .map((shift) => getRow(
                      shift,
                      (type, guard) => guard != null
                          ? updateShift(shift.id, null, type, context)
                          : updateShift(shift.id, authKey, type, context)))
                  .toList(),
              border: TableBorder.all(color: primaryColor),
              showBottomBorder: true,
            ),
          ),
        ],
      ),
    );
  }
}
