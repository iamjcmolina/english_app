import 'package:flutter/foundation.dart';

enum AdjectiveType {
  descriptive,
  numeral,
  quantitative,
  demonstrative,
  interrogative,
  possesive,
  proper,
  exclamatory,
  distributive
}
class Adjective {

  String value;
  AdjectiveType type;

  Adjective({required this.value, required this.type});

  factory Adjective.fromMap(Map<String, dynamic> map) => Adjective(
    value: map['value'],
    type: AdjectiveType.values.firstWhere((e) => describeEnum(e) == map['type']),
  );

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'type': type.toString(),
    };
  }
}
