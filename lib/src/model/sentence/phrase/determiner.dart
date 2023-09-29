import 'value/determiner_type.dart';

class Determiner {
  String value;
  DeterminerType type;
  bool allowsUncountable;
  bool allowsSingular;
  bool allowsPlural;

  Determiner({
    required this.value,
    required this.type,
    required this.allowsUncountable,
    required this.allowsSingular,
    required this.allowsPlural,
  });

  Determiner.article(
      this.value,
      this.allowsUncountable,
      this.allowsSingular,
      this.allowsPlural,
      ) : type = DeterminerType.article;

  Determiner.possessive(this.value)
      : type = DeterminerType.possessive,
        allowsUncountable = true,
        allowsSingular = true,
        allowsPlural = true;

  Determiner.demonstrative(
      this.value,
      this.allowsUncountable,
      this.allowsSingular,
      this.allowsPlural,
      ) : type = DeterminerType.demonstrative;

  Determiner.distributive(
      this.value,
      this.allowsUncountable,
      this.allowsSingular,
      this.allowsPlural,
      ) : type = DeterminerType.distributive;

  Determiner.quantifier(
      this.value,
      this.allowsUncountable,
      this.allowsSingular,
      this.allowsPlural,
      ) : type = DeterminerType.quantifier;

  Determiner.one()
      : type = DeterminerType.number, value = 'one', allowsUncountable = false,
        allowsSingular = true, allowsPlural = false;

  Determiner.naturalNumber(
      this.value,
      ) : type = DeterminerType.number,
        allowsUncountable = false, allowsSingular = false, allowsPlural = true;

  Determiner.ordinalNumber(
      this.value,
      ) : type = DeterminerType.number,
        allowsUncountable = false, allowsSingular = true, allowsPlural = false;

  @override
  String toString() => value;
}
