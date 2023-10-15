import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:shidts/guard.dart';
import 'package:shidts/areas.dart';
import 'package:shidts/hasura_helper.dart';
import 'package:shidts/main.dart';
import 'package:shidts/shift.dart';

class ShiftFetchWidget extends StatelessWidget {
  final String authKey;
  const ShiftFetchWidget({super.key, required this.authKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: fetchShifts(),
        builder: (BuildContext context, AsyncSnapshot<List<Shift>> snapshot) =>
            snapshot.mapSnapshot(
          onSuccess: (shifts) => GuardTable(shifts, authKey),
          onWaiting: () => const Center(child: CircularProgressIndicator()),
          onNoData: () => const Text("No data"),
          onError: (final Object error) => Text(error.toString()),
        ),
      ),
    );
  }
}

const String query = """
subscription FetchShifts {
	shift(order_by:{date: asc, area:asc}) {
    area
    date
    id
    guardEvening1 {
      name
      auth_key
    }
    guardEvening2 {
      name
      auth_key
    }
    guardNight1 {
      name
      auth_key
    }
    guardNight2 {
      name
      auth_key
    }
  }
}
""";

Stream<List<Shift>> fetchShifts() {
  return getClient()
      .subscribe(SubscriptionOptions(
    document: gql(query),
    parserFn: (data) {
      final shifts = data["shift"] as List<dynamic>;
      return shifts.map((e) {
        final date = (e["date"]);

        final evening1 = Guard.fromJson(e["guardEvening1"]);
        final evening2 = Guard.fromJson(e["guardEvening2"]);
        final night1 = Guard.fromJson(e["guardNight1"]);
        final night2 = Guard.fromJson(e["guardNight2"]);
        final id = e["id"];
        return Shift(
          date,
          evening1,
          evening2,
          night1,
          night2,
          fromNumber(e["area"] as int),
          id,
        );
      }).toList();
    },
  ))
      .map((event) {
    final shifts = event.mapQueryResult();
    print("Parsed!");
    return shifts;
  });
}
