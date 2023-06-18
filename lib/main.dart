import 'package:flutter/material.dart';

import '/src/english_app.dart';

void main() {
  //runApp(const EnglishApp());
  print(camelToSentence("camelToSentence"));
}

String camelToSentence(String text) {
  var result = text.replaceAll(RegExp(r'(?<!^)(?=[A-Z])'), r" ");
  var finalResult = result[0].toUpperCase() + result.substring(1);
  return finalResult;
}
