import 'subject_complement.dart';

enum Countability {uncountable, singular, plural}

abstract class AnyNoun extends SubjectComplement {
  const AnyNoun();

  Countability get countability;
  bool get isSingularFirstPerson;
  bool get isSingularThirdPerson;
}
