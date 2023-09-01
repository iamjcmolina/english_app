class Preposition {
  String value;

  Preposition({required this.value});

  factory Preposition.fromMap(Map<String, dynamic> map) => Preposition(
    value: map['value'],
  );

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }
}
