import '../../adverb/adverb.dart';
import '../../adverb/adverb_type.dart';
import '../../clause/adjective_clause.dart';
import '../../noun/noun_phrase.dart';
import '../../nullable.dart';
import '../../verb/verb.dart';
import '../../adjective/adjective.dart';
import '../participle_phrase/present_participle_phrase.dart';
import '../prepositional_phrase/prepositional_phrase.dart';
import 'infinitive_phrase_object_type.dart';
import 'infinitive_phrase_post_modifier_type.dart';

class InfinitivePhrase implements Adverb, Adjective {
  InfinitivePhrase({
    this.bareInfinitive = false,
    this.verb,
    this.objectType,
    this.objectPronoun,
    this.objectNoun,
    this.objectNounPhrase,
    this.modifierType,
    this.modifierAdverb,
    this.modifierAdjective,
    this.modifierPrepositionalPhrase,
    this.modifierPresentParticiplePhrase,
    this.modifierAdjectiveClause,
  });
  bool bareInfinitive;
  Verb? verb;
  InfinitivePhraseObjectType? objectType;
  String? objectPronoun;
  String? objectNoun;
  NounPhrase? objectNounPhrase;
  InfinitivePhrasePostModifierType? modifierType;
  String? modifierAdverb;
  String? modifierAdjective;
  PrepositionalPhrase? modifierPrepositionalPhrase;
  PresentParticiplePhrase? modifierPresentParticiplePhrase;
  AdjectiveClause? modifierAdjectiveClause;

  InfinitivePhrase copyWith({
    bool? bareInfinitive,
    Nullable<Verb>? verb,
    Nullable<InfinitivePhraseObjectType>? objectType,
    Nullable<String>? objectPronoun,
    Nullable<String>? objectNoun,
    Nullable<NounPhrase>? objectNounPhrase,
    Nullable<InfinitivePhrasePostModifierType>? modifierType,
    Nullable<String>? modifierAdverb,
    Nullable<String>? modifierAdjective,
    Nullable<PresentParticiplePhrase>? modifierPresentParticiplePhrase,
    Nullable<AdjectiveClause>? modifierAdjectiveClause,
  }) => InfinitivePhrase(
    bareInfinitive: bareInfinitive ?? this.bareInfinitive,
    verb: verb == null? this.verb : verb.value,
    objectType: objectType == null? this.objectType : objectType.value,
    objectPronoun: objectPronoun == null? this.objectPronoun : objectPronoun.value,
    objectNoun: objectNoun == null? this.objectNoun : objectNoun.value,
    objectNounPhrase: objectNounPhrase == null? this.objectNounPhrase : objectNounPhrase.value,
    modifierType: modifierType == null? this.modifierType : modifierType.value,
    modifierAdverb: modifierAdverb == null? this.modifierAdverb : modifierAdverb.value,
    modifierAdjective: modifierAdjective == null? this.modifierAdjective : modifierAdjective.value,
    modifierPresentParticiplePhrase: modifierPresentParticiplePhrase == null?
        this.modifierPresentParticiplePhrase : modifierPresentParticiplePhrase.value,
    modifierAdjectiveClause: modifierAdjectiveClause == null?
        this.modifierAdjectiveClause : modifierAdjectiveClause.value,
  );

  @override
  String toString() {
    String phrase = '';
    String to = bareInfinitive? '' : ' to';
    phrase += verb == null? ' <Infinitive verb>' : '$to $verb';
    if (objectType == InfinitivePhraseObjectType.pronoun) {
      phrase += objectPronoun == null? ' <Pronoun>' : ' $objectPronoun';
    } else if (objectType == InfinitivePhraseObjectType.noun) {
      phrase += objectNoun == null? ' <Noun>' : ' $objectNoun';
    } else if (objectType == InfinitivePhraseObjectType.nounPhrase) {
      phrase += objectNounPhrase == null? ' <Noun phrase>' : ' $objectNounPhrase';
    }
    if (modifierType == InfinitivePhrasePostModifierType.adverb) {
      phrase += modifierAdverb == null? ' <Adverb>' : ' $modifierAdverb';
    } else if (modifierType == InfinitivePhrasePostModifierType.adjective) {
      phrase += modifierAdjective == null? ' <Adjective>' : ' $modifierAdjective';
    } else if (modifierType == InfinitivePhrasePostModifierType.presentParticiplePhrase) {
      phrase += modifierPresentParticiplePhrase == null? ' <Present participle phrase>' : ' $modifierPresentParticiplePhrase';
    } else  if (modifierType == InfinitivePhrasePostModifierType.adjectiveClause) {
      phrase += modifierAdjectiveClause == null? ' <Adjective phrase>' : ' $modifierAdjectiveClause';
    }
    return phrase;
  }

  @override
  // TODO: implement adverbType, it can be: reason
  AdverbType get adverbType => AdverbType.reasonOrPurpose;
}
