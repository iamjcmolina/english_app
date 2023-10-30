import 'package:flutter/material.dart';

enum SentenceItem {
  adjective(Colors.deepOrange),
  noun(Colors.orange),
  verb(Colors.blue),
  adverb(Colors.purple);

  final Color color;

  const SentenceItem(this.color);
}
