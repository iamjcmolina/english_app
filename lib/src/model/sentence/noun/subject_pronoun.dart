import 'any_noun.dart';
import 'countability.dart';
import 'doer.dart';

class SubjectPronoun extends AnyNoun {
  static const subjectPronouns = [
    SubjectPronoun('I', 'yo', Doer.I),
    SubjectPronoun('you', 'tu/ustedes', Doer.you),
    SubjectPronoun('he', 'él', Doer.he),
    SubjectPronoun('she', 'ella', Doer.she),
    SubjectPronoun('it', 'eso', Doer.it),
    SubjectPronoun('we', 'nosotros', Doer.we),
    SubjectPronoun('they', 'ellos', Doer.they),
  ];
  @override
  final String en;
  @override
  final String es;
  @override
  final Doer asDoer;

  @override
  Countability get countability =>
      ['you', 'we', 'they'].contains(en.toLowerCase())
          ? Countability.plural
          : Countability.singular;

  @override
  bool get isSingularFirstPerson => en.toLowerCase() == 'i';

  @override
  bool get isSingularThirdPerson =>
      ['he', 'she', 'it'].contains(en.toLowerCase());

  @override
  bool get isValid => true;

  const SubjectPronoun(this.en, this.es, this.asDoer);
}
