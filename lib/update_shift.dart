import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:shidts/hasura_helper.dart';
import 'package:shidts/shift.dart';

String getMutation(GuardType type) =>
    """mutation UpdateShift(\$id: Int!, \$guardID: String) {
  update_shift_by_pk(pk_columns: {id: \$id}, _set: {${type.hasuraName}_id: \$guardID}) {
    area
  }
}""";

Future<void> updateShift(
  final int shiftID,
  final String? guardKey,
  final GuardType type,
  final BuildContext context,
) async {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      duration: Duration(seconds: 10),
      backgroundColor: Color(0x00000000),
      behavior: SnackBarBehavior.floating,
      content: Center(
        child: CircularProgressIndicator(),
      ),
    ),
  );
  (await getClient().mutate(
    MutationOptions<void>(
      document: gql(getMutation(type)),
      parserFn: (data) {},
      variables: <String, dynamic>{
        "id": shiftID,
        "guardID": guardKey,
      },
    ),
  ));
  if (context.mounted) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }
}
