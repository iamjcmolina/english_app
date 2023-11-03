import 'any_noun.dart';
import 'countability.dart';
import 'doer.dart';

class Pronoun extends AnyNoun {
  static const subjectPronouns = [
    Pronoun('I', 'yo', Doer.I),
    Pronoun('you', 'tu/ustedes', Doer.you),
    Pronoun('he', 'él', Doer.he),
    Pronoun('she', 'ella', Doer.she),
    Pronoun('it', 'eso', Doer.it),
    Pronoun('we', 'nosotros', Doer.we),
    Pronoun('they', 'ellos', Doer.they),
  ];
  static const objectPronouns = [
    Pronoun('me', 'me', Doer.I),
    Pronoun('you', 'te', Doer.you),
    Pronoun('him', 'lo/le', Doer.he),
    Pronoun('her', 'lo/le', Doer.she),
    Pronoun('it', 'lo/le', Doer.it),
    Pronoun('us', 'nos', Doer.we),
    Pronoun('them', 'les', Doer.they),
  ];
  static const possessivePronouns = [
    Pronoun('mine', 'mio(a)/el mio/la mia/los míos/las mías', Doer.I),
    Pronoun(
        'yours',
        'tuyo/el tuyo/la tuya/los tuyos(as)/suyo/el suyo/la suya/las suyas',
        Doer.you),
    Pronoun('his', 'suyo/el suyo/la suya/los suyos/las suyas', Doer.he),
    Pronoun('hers', 'suyo/el suyo/la suya/los suyos/las suyas', Doer.she),
    Pronoun('its', 'suyo/el suyo/la suya/los suyos/las suyas', Doer.it),
    Pronoun('ours', 'nuestro/el nuestro/la nuestra/los nuestros/las nuestras',
        Doer.we),
    Pronoun('theirs', 'suyo/el suyo/la suya/los suyos/las suyas', Doer.they),
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

  const Pronoun(this.en, this.es, this.asDoer);

  @override
  String toString() => en;
}
