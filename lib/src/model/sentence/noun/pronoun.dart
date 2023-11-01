import 'any_noun.dart';
import 'countability.dart';
import 'doer_pronoun.dart';

class Pronoun extends AnyNoun {
  static const subjectPronouns = [
    Pronoun('I', 'yo', DoerPronoun.I),
    Pronoun('you', 'tu/ustedes', DoerPronoun.you),
    Pronoun('he', 'él', DoerPronoun.he),
    Pronoun('she', 'ella', DoerPronoun.she),
    Pronoun('it', 'eso', DoerPronoun.it),
    Pronoun('we', 'nosotros', DoerPronoun.we),
    Pronoun('they', 'ellos', DoerPronoun.they),
  ];
  static const objectPronouns = [
    Pronoun('me', 'me', DoerPronoun.I),
    Pronoun('you', 'te', DoerPronoun.you),
    Pronoun('him', 'lo/le', DoerPronoun.he),
    Pronoun('her', 'lo/le', DoerPronoun.she),
    Pronoun('it', 'lo/le', DoerPronoun.it),
    Pronoun('us', 'nos', DoerPronoun.we),
    Pronoun('them', 'les', DoerPronoun.they),
  ];
  static const possessivePronouns = [
    Pronoun('mine', 'mio(a)/el mio/la mia/los míos/las mías', DoerPronoun.I),
    Pronoun(
        'yours',
        'tuyo/el tuyo/la tuya/los tuyos(as)/suyo/el suyo/la suya/las suyas',
        DoerPronoun.you),
    Pronoun('his', 'suyo/el suyo/la suya/los suyos/las suyas', DoerPronoun.he),
    Pronoun(
        'hers', 'suyo/el suyo/la suya/los suyos/las suyas', DoerPronoun.she),
    Pronoun('its', 'suyo/el suyo/la suya/los suyos/las suyas', DoerPronoun.it),
    Pronoun('ours', 'nuestro/el nuestro/la nuestra/los nuestros/las nuestras',
        DoerPronoun.we),
    Pronoun(
        'theirs', 'suyo/el suyo/la suya/los suyos/las suyas', DoerPronoun.they),
  ];
  @override
  final String en;
  @override
  final String es;
  @override
  final DoerPronoun asPronoun;

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

  const Pronoun(this.en, this.es, this.asPronoun);

  @override
  String toString() => en;
}
