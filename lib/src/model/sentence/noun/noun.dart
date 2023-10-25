import 'any_noun.dart';

class Noun extends AnyNoun {
  @override
  final String en;
  @override
  final String es;
  @override
  final Countability countability;

  @override
  PersonalPronoun get asPronoun =>
      isPlural ? PersonalPronoun.they : PersonalPronoun.it;

  @override
  bool get isSingularFirstPerson => false;

  @override
  bool get isSingularThirdPerson => isSingular;

  const Noun(this.en, this.es, this.countability);

  @override
  String toString() => en;
}
