import 'any_noun.dart';
import 'countability.dart';
import 'doer.dart';

class ObjectPronoun extends AnyNoun {
  static const objectPronouns = [
    ObjectPronoun('me', 'me/mi', Doer.I),
    ObjectPronoun('you', 'te/ti/tu', Doer.you),
    ObjectPronoun('him', 'lo/le', Doer.he),
    ObjectPronoun('her', 'la/lo/le', Doer.she),
    ObjectPronoun('it', 'lo/le', Doer.it),
    ObjectPronoun('us', 'nos', Doer.we),
    ObjectPronoun('them', 'les', Doer.they),
  ];
  @override
  final String en;
  @override
  final String es;
  @override
  final Doer asDoer;

  @override
  Countability get countability =>
      ['you', 'us', 'them'].contains(en.toLowerCase())
          ? Countability.plural
          : Countability.singular;

  @override
  bool get isSingularFirstPerson => en.toLowerCase() == 'me';

  @override
  bool get isSingularThirdPerson =>
      ['him', 'her', 'it'].contains(en.toLowerCase());

  @override
  bool get isValid => true;

  const ObjectPronoun(this.en, this.es, this.asDoer);
}
