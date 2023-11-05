import 'determiner_type.dart';

class Determiner {
  static const articles = [
    Determiner.article('a', 'un/una', false, true, false),
    Determiner.article('an', 'un/una', false, true, false),
    Determiner.article('the', 'el/la/los/las', true, true, true),
  ];
  static const possessiveAdjectives = [
    Determiner.possessiveAdjective('my', 'mi/mis'),
    Determiner.possessiveAdjective('your', 'tu/tus/su/sus'),
    Determiner.possessiveAdjective('his', 'su/sus'),
    Determiner.possessiveAdjective('her', 'su/sus'),
    Determiner.possessiveAdjective('its', 'su/sus'),
    Determiner.possessiveAdjective('our', 'nuestro/nuestros'),
    Determiner.possessiveAdjective('their', 'su/sus'),
  ];
  static const demonstrativeAdjectives = [
    Determiner.demonstrative('this', 'este/esta', true, true, false),
    Determiner.demonstrative('that', 'ese/esa', true, true, false),
    Determiner.demonstrative('these', 'estos/estas', false, false, true),
    Determiner.demonstrative('those', 'esos/esas', false, false, true),
  ];
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

  const Determiner.article(
    this.en,
    this.es,
    this.allowsUncountable,
    this.allowsSingular,
    this.allowsPlural,
  ) : type = DeterminerType.article;

  const Determiner.possessiveAdjective(this.en, this.es)
      : type = DeterminerType.possessive,
        allowsUncountable = true,
        allowsSingular = true,
        allowsPlural = true;

  const Determiner.demonstrative(
    this.en,
    this.es,
    this.allowsUncountable,
    this.allowsSingular,
    this.allowsPlural,
  ) : type = DeterminerType.demonstrative;

  const Determiner.distributiveAdjective(
    this.en,
    this.es,
    this.allowsUncountable,
    this.allowsSingular,
    this.allowsPlural,
  ) : type = DeterminerType.distributive;

  const Determiner.quantifier(
    this.en,
    this.es,
    this.allowsUncountable,
    this.allowsSingular,
    this.allowsPlural,
  ) : type = DeterminerType.quantifier;

  const Determiner.one()
      : type = DeterminerType.number,
        en = 'one',
        es = 'uno/una',
        allowsUncountable = false,
        allowsSingular = true,
        allowsPlural = false;

  const Determiner.naturalNumber(
    this.en,
    this.es,
  )   : type = DeterminerType.number,
        allowsUncountable = false,
        allowsSingular = false,
        allowsPlural = true;

  const Determiner.ordinalNumber(
    this.en,
    this.es,
  )   : type = DeterminerType.number,
        allowsUncountable = false,
        allowsSingular = true,
        allowsPlural = false;
}
