import 'any_noun.dart';

class UndefinedSubject extends AnyNoun {
  const UndefinedSubject();

  @override
  Countability get countability => Countability.singular;

  @override
  bool get isSingularFirstPerson => true;

  @override
  bool get isSingularThirdPerson => false;

  @override
  String toString() => '<Subject>';
}
