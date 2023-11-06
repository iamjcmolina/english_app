import 'countability.dart';
import 'doer.dart';
import 'subject_complement.dart';

abstract class AnyNoun extends SubjectComplement {
  @override
  bool get isValid;
  @override
  String get en;
  String get es;
  Countability get countability;
  Doer get asDoer;
  Doer get asDoerEs => asDoer;
  bool get isSingularFirstPerson => false;
  bool get isSingularThirdPerson;

  bool get isUncountable => countability == Countability.uncountable;
  bool get isSingular => countability == Countability.singular;
  bool get isPlural => countability == Countability.plural;

  const AnyNoun();

  @override
  String toEs([bool? isPluralSubject]) => es;
}
