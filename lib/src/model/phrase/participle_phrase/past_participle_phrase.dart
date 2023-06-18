import '../../clause/adjective_clause.dart';
import '../../noun/noun_phrase.dart';
import '../../nullable.dart';
import '../../verb/verb.dart';
import '../../adjective/adjective.dart';
import '../infinitive_phrase/infinitive_phrase.dart';
import '../prepositional_phrase/prepositional_phrase.dart';
import 'past_participle_phrase_modifier_type.dart';
import 'past_participle_phrase_object_type.dart';
import 'present_participle_phrase.dart';

class PastParticiplePhrase implements Adjective {
  PastParticiplePhrase({
    this.pastParticipleVerb,
    this.participlePhraseObjectType = PastParticiplePhraseObjectType.pronoun,
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

  Verb? pastParticipleVerb;
  PastParticiplePhraseObjectType participlePhraseObjectType;
  String? pronoun;
  String? noun;
  NounPhrase? nounPhrase;
  PastParticiplePhraseModifierType? modifierType;
  PrepositionalPhrase? prepositionalPhrase;
  PresentParticiplePhrase? presentParticiplePhrase;
  PastParticiplePhrase? pastParticiplePhrase;
  InfinitivePhrase? infinitivePhrase;
  AdjectiveClause? adjectiveClause;

  PastParticiplePhrase copyWith({
    Nullable<Verb>? pastParticipleVerb,
    PastParticiplePhraseObjectType? participlePhraseObjectType,
    Nullable<String>? pronoun,
    Nullable<String>? noun,
    NounPhrase? nounPhrase,
    PastParticiplePhraseModifierType? modifierType,
    PrepositionalPhrase? prepositionalPhrase,
    PresentParticiplePhrase? presentParticiplePhrase,
    PastParticiplePhrase? pastParticiplePhrase,
    InfinitivePhrase? infinitivePhrase,
    AdjectiveClause? adjectiveClause,
  }) => PastParticiplePhrase(
    pastParticipleVerb: pastParticipleVerb==null? this.pastParticipleVerb : pastParticipleVerb.value,
    participlePhraseObjectType: participlePhraseObjectType ?? this.participlePhraseObjectType,
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
    phrase += pastParticipleVerb==null? ' <Past participle verb>' : ' $pastParticipleVerb';
    if (participlePhraseObjectType == PastParticiplePhraseObjectType.pronoun) {
      phrase += pronoun==null? ' <Pronoun>' : ' $pronoun';
    } else if (participlePhraseObjectType == PastParticiplePhraseObjectType.noun) {
      phrase += noun==null? ' <Noun>' : ' $noun';
    } else if (participlePhraseObjectType == PastParticiplePhraseObjectType.nounPhrase) {
      phrase += nounPhrase==null? ' <Noun phrase>' : ' $nounPhrase';
    }
    if (modifierType == PastParticiplePhraseModifierType.prepositionalPhrase) {
      phrase += prepositionalPhrase==null? ' <Prepositional phrase>' : ' $prepositionalPhrase';
    } else if (modifierType == PastParticiplePhraseModifierType.presentParticiplePhrase) {
      phrase += presentParticiplePhrase==null? ' <Present participle phrase>' : ' $presentParticiplePhrase';
    } else if (modifierType == PastParticiplePhraseModifierType.pastParticiplePhrase) {
      phrase += pastParticiplePhrase==null? ' <Past participle phrase>' : ' $pastParticiplePhrase';
    } else if (modifierType == PastParticiplePhraseModifierType.infinitivePhrase) {
      phrase += infinitivePhrase==null? ' <Infinitive phrase>' : ' $infinitivePhrase';
    } else if (modifierType == PastParticiplePhraseModifierType.adjectiveClause) {
      phrase += adjectiveClause==null? ' <Adjective phrase>' : ' $adjectiveClause';
    }
    return phrase;
  }
}
