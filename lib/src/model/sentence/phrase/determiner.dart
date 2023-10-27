import 'value/determiner_type.dart';

class Determiner {
  final String en;
  final String es;
  final DeterminerType type;
  final bool isUncountableAllowed;
  final bool isSingularAllowed;
  final bool isPluralAllowed;

  const Determiner({
    required this.en,
    required this.es,
    required this.type,
    required this.isUncountableAllowed,
    required this.isSingularAllowed,
    required this.isPluralAllowed,
  });

  const Determiner.article(
    this.en,
    this.es,
    this.isUncountableAllowed,
    this.isSingularAllowed,
    this.isPluralAllowed,
  ) : type = DeterminerType.article;

  const Determiner.possessive(this.en, this.es)
      : type = DeterminerType.possessive,
        isUncountableAllowed = true,
        isSingularAllowed = true,
        isPluralAllowed = true;

  const Determiner.demonstrative(
    this.en,
    this.es,
    this.isUncountableAllowed,
    this.isSingularAllowed,
    this.isPluralAllowed,
  ) : type = DeterminerType.demonstrative;

  const Determiner.distributiveAdjective(
    this.en,
    this.es,
    this.isUncountableAllowed,
    this.isSingularAllowed,
    this.isPluralAllowed,
  ) : type = DeterminerType.distributive;

  const Determiner.quantifier(
    this.en,
    this.es,
    this.isUncountableAllowed,
    this.isSingularAllowed,
    this.isPluralAllowed,
  ) : type = DeterminerType.quantifier;

  const Determiner.one()
      : type = DeterminerType.number,
        en = 'one',
        es = 'uno/una',
        isUncountableAllowed = false,
        isSingularAllowed = true,
        isPluralAllowed = false;

  const Determiner.naturalNumber(
    this.en,
    this.es,
  )   : type = DeterminerType.number,
        isUncountableAllowed = false,
        isSingularAllowed = false,
        isPluralAllowed = true;

  const Determiner.ordinalNumber(
    this.en,
    this.es,
  )   : type = DeterminerType.number,
        isUncountableAllowed = false,
        isSingularAllowed = true,
        isPluralAllowed = false;

  @override
  String toString() => en;
}
