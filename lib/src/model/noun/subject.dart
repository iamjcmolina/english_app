// SubjectPronoun | OwnName | NounPhrase | GerundPhrase | InfinitivePhrase
abstract class Subject {
  bool get singular;
  bool get plural;
  bool get singularFirstPerson;
  bool get singularThirdPerson;
}
