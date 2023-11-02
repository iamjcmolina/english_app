import 'any_noun.dart';
import 'countability.dart';
import 'doer_pronoun.dart';

class IndefinitePronoun extends AnyNoun {
  @override
  final String en;
  @override
  final String es;
  @override
  final Countability countability;
  final Countability countabilityEs;
  final String description;

  @override
  DoerPronoun get asPronoun => isPlural ? DoerPronoun.they : DoerPronoun.it;

  DoerPronoun get asPronounEs =>
      countabilityEs == Countability.plural ? DoerPronoun.they : DoerPronoun.it;

  @override
  bool get isSingularThirdPerson => isSingular;

  bool get isNegativeOnlyAllowed => en.startsWith('any');

  @override
  bool get isValid => true;

  const IndefinitePronoun(this.en, this.es, this.countability,
      this.countabilityEs, this.description);

  @override
  String toString() => en;
}
