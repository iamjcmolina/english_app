import 'any_noun.dart';

class Pronoun extends AnyNoun {
  @override
  final String en;
  @override
  final String es;
  @override
  final PersonalPronoun asPronoun;

  @override
  Countability get countability =>
      ['you', 'we', 'they'].contains(en.toLowerCase())
          ? Countability.plural
          : Countability.singular;

  @override
  bool get isSingularFirstPerson => en.toLowerCase() == 'i';

  @override
  bool get isSingularThirdPerson =>
      ['he', 'she', 'it'].contains(en.toLowerCase());

  const Pronoun(this.en, this.es, this.asPronoun);

  @override
  String toString() => en;
}
