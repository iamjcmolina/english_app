class Adverb {
  String value;

  Adverb({required this.value});

  factory Adverb.fromMap(Map<String, dynamic> map) => Adverb(
    value: map['value'],
  );

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }
}