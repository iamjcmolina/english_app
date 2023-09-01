class Verb {
  String value;

  Verb({required this.value});

  factory Verb.fromMap(Map<String, dynamic> map) => Verb(
    value: map['value'],
  );

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }
}
