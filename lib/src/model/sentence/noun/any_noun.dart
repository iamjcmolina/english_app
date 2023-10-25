import 'subject_complement.dart';

enum Countability { uncountable, singular, plural }

enum PersonalPronoun { I, you, he, she, it, we, they }

abstract class AnyNoun extends SubjectComplement {
  String get en;
  String get es;
  Countability get countability;
  PersonalPronoun get asPronoun;
  bool get isSingularFirstPerson;
  bool get isSingularThirdPerson;

  bool get isUncountable => countability == Countability.uncountable;
  bool get isSingular => countability == Countability.singular;
  bool get isPlural => countability == Countability.plural;

  const AnyNoun();
}
