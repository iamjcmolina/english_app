import '../../nullable.dart';
import '../adjective/adjective.dart';
import '../adjective/any_adjective.dart';
import '../determiner/determiner.dart';
import '../determiner/determiner_type.dart';
import '../noun/any_noun.dart';
import '../noun/countability.dart';
import '../noun/doer.dart';
import '../noun/noun.dart';
import '../text_buffer.dart';

class NounPhrase extends AnyNoun {
  final Determiner? quantifier;
  final Determiner? determiner;
  final Determiner? number;
  final Adjective? adjective;
  final Noun? noun;
  final AnyAdjective? adjectivalPhrase;

  @override
  String get en => TextBuffer()
      .add(quantifier?.en, when: allowQuantifier)
      .add(determiner?.en)
      .add(number?.en, when: allowNumber)
      .add(adjective?.en, when: allowAdjective)
      .add(noun?.en)
      .toString();

  @override
  String get es => TextBuffer()
      .add(quantifier?.es, when: allowQuantifier)
      .add(determiner?.es)
      .add(number?.es, when: allowNumber)
      .add(noun?.es)
      .add(adjective?.toEs(isPlural), when: allowAdjective)
      .toString();

  @override
  Countability get countability => noun?.countability ?? Countability.singular;

  @override
  Doer get asDoer => noun?.asDoer ?? Doer.it;

  @override
  bool get isSingularFirstPerson => noun?.isSingularFirstPerson ?? false;

  @override
  bool get isSingularThirdPerson => noun?.isSingularThirdPerson ?? true;

  bool get allowQuantifier =>
      number == null &&
      adjective == null &&
      determiner?.type == DeterminerType.possessive;

  bool get allowNumber =>
      quantifier == null &&
      determiner?.type != null &&
      determiner?.type != DeterminerType.number;

  bool get allowAdjective => quantifier == null;

  String? get quantifierOf => quantifier == null
      ? null
      : '$quantifier'
          '${quantifier!.en.contains('of') ? '' : ' of'}';

  String? get quantifierOfEs => quantifier == null
      ? null
      : '${quantifier!.es}'
          '${quantifier!.en.contains('of') ? '' : ' de'}';

  @override
  bool get isValid => determiner != null && noun != null;

  const NounPhrase({
    this.quantifier,
    this.determiner,
    this.number,
    this.adjective,
    this.noun,
    this.adjectivalPhrase,
  });

  NounPhrase copyWith({
    Nullable<Determiner>? quantifier,
    Nullable<Determiner>? determiner,
    Nullable<Determiner>? number,
    Nullable<Adjective>? adjective,
    Nullable<Noun>? noun,
    Nullable<AnyAdjective>? adjectivalPhrase,
  }) =>
      NounPhrase(
        quantifier: quantifier == null ? this.quantifier : quantifier.value,
        determiner: determiner == null ? this.determiner : determiner.value,
        number: number == null ? this.number : number.value,
        adjective: adjective == null ? this.adjective : adjective.value,
        noun: noun == null ? this.noun : noun.value,
        adjectivalPhrase: adjectivalPhrase == null
            ? this.adjectivalPhrase
            : adjectivalPhrase.value,
      );
}
