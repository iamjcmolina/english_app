enum Countability {uncountable, singular, plural}

abstract class AnyNoun {
  const AnyNoun();

  Countability get countability;
  bool get isSingularFirstPerson;
  bool get isSingularThirdPerson;
}
