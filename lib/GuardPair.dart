import 'package:flutter/material.dart';

class GuardPair extends StatelessWidget {
  final List<String> guards;

  GuardPair(this.guards);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: guards.map((guard) => Text(guard)).toList(),
    );
  }
}
