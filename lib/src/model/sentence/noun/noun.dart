import 'any_noun.dart';

class Noun extends AnyNoun {
  @override
  final String en;
  @override
  final String es;
  @override
  final Countability countability;

  @override
  DoerPronoun get asPronoun => isPlural ? DoerPronoun.they : DoerPronoun.it;

  @override
  bool get isSingularThirdPerson => isSingular;

  const Noun(this.en, this.es, this.countability);

  @override
  String toString() => en;
}
