import 'any_noun.dart';

class UndefinedIndirectObject extends AnyNoun {
  const UndefinedIndirectObject();

  @override
  String toString() => '<IndirectObject>';

  @override
  Countability get countability => Countability.singular;

  @override
  bool get isSingularFirstPerson => true;

  @override
  bool get isSingularThirdPerson => false;
}
