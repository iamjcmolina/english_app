import '../../nullable.dart';
import '../noun/any_noun.dart';
import '../noun/noun.dart';
import '../sentence_buffer.dart';
import 'determiner.dart';
import 'value/determiner_type.dart';

class NounPhrase extends AnyNoun {
  Determiner? quantifier;
  Determiner? determiner;
  Determiner? number;
  String? adjective;
  Noun? noun;

  NounPhrase({
    this.quantifier,
    this.determiner,
    this.number,
    this.adjective,
    this.noun
  });

  NounPhrase copyWith({
    Nullable<Determiner>? quantifierOf,
    Nullable<Determiner>? determiner,
    Nullable<Determiner>? number,
    Nullable<String>? adjective,
    Nullable<Noun>? noun,
  }) => NounPhrase(
    quantifier: quantifierOf == null? this.quantifier : quantifierOf.value,
    determiner: determiner == null? this.determiner : determiner.value,
    number: number == null? this.number : number.value,
    adjective: adjective == null? this.adjective : adjective.value,
    noun: noun == null? this.noun : noun.value,
  );

  @override
  Countability get countability => noun?.countability ?? Countability.singular;

  @override
  bool get isSingularFirstPerson => noun?.isSingularFirstPerson ?? false;

  @override
  bool get isSingularThirdPerson => noun?.isSingularThirdPerson ?? true;

  bool get allowQuantifier => number == null && adjective == null
      && determiner?.type == DeterminerType.possessive;
  bool get allowNumber => quantifier == null && determiner?.type != null
      && determiner?.type != DeterminerType.number;
  bool get allowAdjective => quantifier == null;

  String? get quantifierText => quantifier == null? null : '$quantifier'
  '${quantifier!.value.contains('of')? '' : ' of'}';


  @override
  String toString() {
    SentenceBuffer buffer = SentenceBuffer();
    buffer.add(quantifier, when: allowQuantifier, disablePrefixWhen: true);
    buffer.add(determiner);
    buffer.add(number, when: allowNumber);
    buffer.add(adjective, when: allowAdjective);
    buffer.add(noun);
    return buffer.toString();
  }
}
