import 'any_noun.dart';
import 'countability.dart';
import 'doer.dart';

class IndefinitePronoun extends AnyNoun {
  @override
  final String en;
  @override
  final String es;
  @override
  final Countability countability;
  final Countability countabilityEs;
  final String help;

  @override
  Doer get asDoer => isPlural ? Doer.they : Doer.it;

  @override
  Doer get asDoerEs =>
      countabilityEs == Countability.plural ? Doer.they : Doer.it;

  @override
  bool get isSingularThirdPerson => isSingular;

  bool get isNegativeOnlyAllowed => en.startsWith('any');

  @override
  bool get isValid => true;

  const IndefinitePronoun(
      this.en, this.es, this.countability, this.countabilityEs, this.help);
}
