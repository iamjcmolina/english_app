import 'any_noun.dart';

class Pronoun extends AnyNoun {
  String value;

  Pronoun(this.value);

  @override
  bool get isSingularFirstPerson => value.toLowerCase() == 'i';

  @override
  bool get isSingularThirdPerson => ['he','she','it'].contains(value.toLowerCase());

  @override
  Countability get countability {
    if (['you','we','they'].contains(value.toLowerCase())) {
      return Countability.plural;
    }
    return Countability.singular;
  }

  @override
  String toString() => value;
}
