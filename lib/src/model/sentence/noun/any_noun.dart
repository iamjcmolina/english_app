import 'countability.dart';
import 'doer_pronoun.dart';
import 'subject_complement.dart';

abstract class AnyNoun extends SubjectComplement {
  @override
  bool get isValid;
  @override
  String get en;
  @override
  String get es;
  Countability get countability;
  DoerPronoun get asPronoun;
  bool get isSingularFirstPerson => false;
  bool get isSingularThirdPerson;

  bool get isUncountable => countability == Countability.uncountable;
  bool get isSingular => countability == Countability.singular;
  bool get isPlural => countability == Countability.plural;

  const AnyNoun();
}
