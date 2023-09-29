import 'any_noun.dart';

class Noun extends AnyNoun {
  final String value;
  @override
  final Countability countability;

  Noun(this.value,this.countability);

  @override
  bool get isSingularFirstPerson => false;

  @override
  bool get isSingularThirdPerson => countability == Countability.singular;

  @override
  String toString() => value;
}
