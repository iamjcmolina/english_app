class Noun {
  bool isCountable;
  bool isSingular;
  String value;

  Noun({
    required this.isCountable,
    required this.isSingular,
    required this.value,
  });

  Noun.countable({required this.value, required this.isSingular}):
        isCountable = true;

  Noun.uncountable(this.value):
        isCountable = false,
        isSingular = true;
}
