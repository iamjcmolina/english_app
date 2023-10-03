import 'any_noun.dart';

class UndefinedDirectObject extends AnyNoun {
  const UndefinedDirectObject();

  @override
  String toString() => '<DirectObject>';

  @override
  Countability get countability => Countability.singular;

  @override
  bool get isSingularFirstPerson => true;

  @override
  bool get isSingularThirdPerson => false;
}
