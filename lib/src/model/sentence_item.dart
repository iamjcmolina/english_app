import 'package:flutter/material.dart';

enum SentenceItem {
  placeholder(TextStyle(fontSize: 12)),
  determiner(TextStyle(color: Colors.cyan)),
  adjective(TextStyle(color: Colors.deepOrange)),
  noun(TextStyle(color: Colors.orange)),
  verb(TextStyle(color: Colors.blue)),
  adverb(TextStyle(color: Colors.purple)),
  preposition(TextStyle(color: Colors.green));

  final TextStyle style;

  const SentenceItem(this.style);
}
