import 'any_noun.dart';
import 'countability.dart';
import 'doer.dart';

class Noun extends AnyNoun {
  @override
  final String en;
  @override
  final String es;
  @override
  final Countability countability;

  @override
  Doer get asDoer => isPlural ? Doer.they : Doer.it;

  @override
  bool get isSingularThirdPerson => isSingular;

  @override
  bool get isValid => true;

  const Noun(this.en, this.es, this.countability);

  @override
  String toString() => en;
}
