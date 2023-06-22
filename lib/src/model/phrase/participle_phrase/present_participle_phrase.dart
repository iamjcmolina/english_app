import '../../adjective/adjective.dart';
import '../../adverb/adverb.dart';
import '../../adverb/adverb_type.dart';
import '../../clause/adjective_clause.dart';
import '../../noun/noun_phrase.dart';
import '../../nullable.dart';
import '../../verb/verb.dart';
import '../infinitive_phrase/infinitive_phrase.dart';
import '../prepositional_phrase/prepositional_phrase.dart';
import 'past_participle_phrase.dart';
import 'present_participle_phrase_modifier_type.dart';
import 'present_participle_phrase_object_type.dart';

class PresentParticiplePhrase implements Adverb, Adjective {
  PresentParticiplePhrase({
    this.presentParticipleVerb,
    this.objectType = PresentParticiplePhraseObjectType.pronoun,
    this.pronoun,
    this.noun,
    this.nounPhrase,
    this.modifierType,
    this.prepositionalPhrase,
    this.presentParticiplePhrase,
    this.pastParticiplePhrase,
    this.infinitivePhrase,
    this.adjectiveClause,
  });

  Verb? presentParticipleVerb;
  PresentParticiplePhraseObjectType objectType;
  String? pronoun;
  String? noun;
  NounPhrase? nounPhrase;
  PresentParticiplePhraseModifierType? modifierType;
  PrepositionalPhrase? prepositionalPhrase;
  PresentParticiplePhrase? presentParticiplePhrase;
  PastParticiplePhrase? pastParticiplePhrase;
  InfinitivePhrase? infinitivePhrase;
  AdjectiveClause? adjectiveClause;

  PresentParticiplePhrase copyWith({
    Nullable<Verb>? presentParticipleVerb,
    PresentParticiplePhraseObjectType? objectType,
    Nullable<String>? pronoun,
    Nullable<String>? noun,
    NounPhrase? nounPhrase,
    PresentParticiplePhraseModifierType? modifierType,
    PrepositionalPhrase? prepositionalPhrase,
    PresentParticiplePhrase? presentParticiplePhrase,
    PastParticiplePhrase? pastParticiplePhrase,
    InfinitivePhrase? infinitivePhrase,
    AdjectiveClause? adjectiveClause,
  }) => PresentParticiplePhrase(
    presentParticipleVerb: presentParticipleVerb==null? this.presentParticipleVerb : presentParticipleVerb.value,
    objectType: objectType ?? this.objectType,
    pronoun: pronoun==null? this.pronoun : pronoun.value,
    noun: noun==null? this.noun : noun.value,
    nounPhrase: nounPhrase ?? this.nounPhrase,
    modifierType: modifierType ?? this.modifierType,
    prepositionalPhrase: prepositionalPhrase ?? this.prepositionalPhrase,
    presentParticiplePhrase: presentParticiplePhrase ?? this.presentParticiplePhrase,
    pastParticiplePhrase: pastParticiplePhrase ?? this.pastParticiplePhrase,
    infinitivePhrase: infinitivePhrase ?? this.infinitivePhrase,
    adjectiveClause: adjectiveClause ?? this.adjectiveClause,
  );

  @override
  String toString() {
    String phrase = '';
    phrase += presentParticipleVerb==null? ' <Present participle verb>' : ' $presentParticipleVerb';
    if (objectType == PresentParticiplePhraseObjectType.pronoun) {
      phrase += pronoun==null? ' <Pronoun>' : ' $pronoun';
    } else if (objectType == PresentParticiplePhraseObjectType.noun) {
      phrase += noun==null? ' <Noun>' : ' $noun';
    } else if (objectType == PresentParticiplePhraseObjectType.nounPhrase) {
      phrase += nounPhrase==null? ' <Noun phrase>' : ' $nounPhrase';
    }
    if (modifierType == PresentParticiplePhraseModifierType.prepositionalPhrase) {
      phrase += prepositionalPhrase==null? ' <Prepositional phrase>' : ' $prepositionalPhrase';
    } else if (modifierType == PresentParticiplePhraseModifierType.presentParticiplePhrase) {
      phrase += presentParticiplePhrase==null? ' <Present participle phrase>' : ' $presentParticiplePhrase';
    } else if (modifierType == PresentParticiplePhraseModifierType.pastParticiplePhrase) {
      phrase += pastParticiplePhrase==null? ' <Past participle phrase>' : ' $pastParticiplePhrase';
    } else if (modifierType == PresentParticiplePhraseModifierType.infinitivePhrase) {
      phrase += infinitivePhrase==null? ' <Infinitive phrase>' : ' $infinitivePhrase';
    } else if (modifierType == PresentParticiplePhraseModifierType.adjectiveClause) {
      phrase += adjectiveClause==null? ' <Adjective phrase>' : ' $adjectiveClause';
    }
    return phrase;
  }

  @override
  // TODO: implement adverbType, it can be: reason
  AdverbType get adverbType => throw UnimplementedError();
}
