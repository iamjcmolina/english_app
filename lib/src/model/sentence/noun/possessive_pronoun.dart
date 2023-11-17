import 'any_noun.dart';
import 'countability.dart';
import 'doer.dart';

class PossessivePronoun extends AnyNoun {
  static const possessivePronouns = [
    PossessivePronoun('mine', 'mio(a)/el mio/la mia/los míos/las mías', Doer.I),
    PossessivePronoun(
        'yours',
        'tuyo/el tuyo/la tuya/los tuyos(as)/suyo/el suyo/la suya/las suyas',
        Doer.you),
    PossessivePronoun(
        'his', 'suyo/el suyo/la suya/los suyos/las suyas', Doer.he),
    PossessivePronoun(
        'hers', 'suyo/el suyo/la suya/los suyos/las suyas', Doer.she),
    PossessivePronoun(
        'its', 'suyo/el suyo/la suya/los suyos/las suyas', Doer.it),
    PossessivePronoun('ours',
        'nuestro/el nuestro/la nuestra/los nuestros/las nuestras', Doer.we),
    PossessivePronoun(
        'theirs', 'suyo/el suyo/la suya/los suyos/las suyas', Doer.they),
  ];
  @override
  final String en;
  @override
  final String es;
  @override
  final Doer asDoer;

  @override
  Countability get countability =>
      ['yours', 'ours', 'theirs'].contains(en.toLowerCase())
          ? Countability.plural
          : Countability.singular;

  @override
  bool get isSingularFirstPerson => en.toLowerCase() == 'mine';

  @override
  bool get isSingularThirdPerson =>
      ['his', 'hers', 'its'].contains(en.toLowerCase());

  @override
  bool get isValid => true;

  const PossessivePronoun(this.en, this.es, this.asDoer);
}
