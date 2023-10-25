import 'value/determiner_type.dart';

class Determiner {
  final String en;
  final String es;
  final DeterminerType type;
  final bool allowsUncountable;
  final bool allowsSingular;
  final bool allowsPlural;

  const Determiner({
    required this.en,
    required this.es,
    required this.type,
    required this.allowsUncountable,
    required this.allowsSingular,
    required this.allowsPlural,
  });

  Determiner.article(
    this.en,
    this.es,
    this.allowsUncountable,
    this.allowsSingular,
    this.allowsPlural,
  ) : type = DeterminerType.article;

  Determiner.possessive(this.en, this.es)
      : type = DeterminerType.possessive,
        allowsUncountable = true,
        allowsSingular = true,
        allowsPlural = true;

  Determiner.demonstrative(
    this.en,
    this.es,
    this.allowsUncountable,
    this.allowsSingular,
    this.allowsPlural,
  ) : type = DeterminerType.demonstrative;

  Determiner.distributive(
    this.en,
    this.es,
    this.allowsUncountable,
    this.allowsSingular,
    this.allowsPlural,
  ) : type = DeterminerType.distributive;

  Determiner.quantifier(
    this.en,
    this.es,
    this.allowsUncountable,
    this.allowsSingular,
    this.allowsPlural,
  ) : type = DeterminerType.quantifier;

  Determiner.one()
      : type = DeterminerType.number,
        en = 'one',
        es = 'uno/una',
        allowsUncountable = false,
        allowsSingular = true,
        allowsPlural = false;

  Determiner.naturalNumber(
    this.en,
    this.es,
  )   : type = DeterminerType.number,
        allowsUncountable = false,
        allowsSingular = false,
        allowsPlural = true;

  Determiner.ordinalNumber(
    this.en,
    this.es,
  )   : type = DeterminerType.number,
        allowsUncountable = false,
        allowsSingular = true,
        allowsPlural = false;

  @override
  String toString() => en;
}
