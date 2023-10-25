import 'package:flutter/material.dart';

enum SentenceItem {
  noun(Colors.orange),
  verb(Colors.blue),
  adverb(Colors.purple);

  final Color color;

  const SentenceItem(this.color);
}
