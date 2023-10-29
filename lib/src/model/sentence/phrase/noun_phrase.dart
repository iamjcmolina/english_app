import '../../nullable.dart';
import '../adjective/adjective.dart';
import '../noun/any_noun.dart';
import '../noun/noun.dart';
import '../sentence_buffer.dart';
import 'determiner.dart';
import 'value/determiner_type.dart';

class NounPhrase extends AnyNoun {
  Determiner? quantifier;
  Determiner? determiner;
  Determiner? number;
  Adjective? adjective;
  Noun? noun;

  @override
  String get en {
    SentenceBuffer buffer = SentenceBuffer();
    buffer.add(quantifier, when: allowQuantifier, disablePrefixWhen: true);
    buffer.add(determiner);
    buffer.add(number, when: allowNumber);
    buffer.add(adjective, when: allowAdjective);
    buffer.add(noun);
    return buffer.toString();
  }

  @override
  String get es {
    SentenceBuffer buffer = SentenceBuffer();
    buffer.add(quantifier?.es, when: allowQuantifier, disablePrefixWhen: true);
    buffer.add(determiner?.es);
    buffer.add(number?.es, when: allowNumber);
    buffer.add(noun?.es);
    buffer.add(adjectiveEs, when: allowAdjective);
    return buffer.toString();
  }

  @override
  Countability get countability => noun?.countability ?? Countability.singular;

  @override
  DoerPronoun get asPronoun => noun?.asPronoun ?? DoerPronoun.it;

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

  String? get adjectiveEs =>
      isPlural ? adjective?.pluralEs : adjective?.singularEs;

  NounPhrase({
    this.quantifier,
    this.determiner,
    this.number,
    this.adjective,
    this.noun,
  });

  NounPhrase copyWith({
    Nullable<Determiner>? quantifier,
    Nullable<Determiner>? determiner,
    Nullable<Determiner>? number,
    Nullable<Adjective>? adjective,
    Nullable<Noun>? noun,
  }) =>
      NounPhrase(
        quantifier: quantifier == null ? this.quantifier : quantifier.value,
        determiner: determiner == null ? this.determiner : determiner.value,
        number: number == null ? this.number : number.value,
        adjective: adjective == null ? this.adjective : adjective.value,
        noun: noun == null ? this.noun : noun.value,
      );

  @override
  String toString() => en;
}
