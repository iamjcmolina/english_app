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

  const Determiner.possessiveAdjective(this.en, this.es)
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
