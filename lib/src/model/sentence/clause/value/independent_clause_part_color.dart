import 'package:flutter/material.dart';

enum IndependentClausePartColor {
  noun(Colors.orange),
  verb(Colors.blue),
  adverb(Colors.purple);
  final Color color;

  const IndependentClausePartColor(this.color);
}
