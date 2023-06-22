import '../../clause/adjective_clause.dart';
import '../../nullable.dart';
import '../infinitive_phrase/infinitive_phrase.dart';
import '../participle_phrase/past_participle_phrase.dart';
import '../participle_phrase/present_participle_phrase.dart';
import 'prepositional_phrase.dart';
import 'prepositional_phrase_modifier_type.dart';

class PrepositionalPhraseModifier {
  PrepositionalPhraseModifierType? modifierType;
  PrepositionalPhrase? modifierPrepositionalPhrase;
  PresentParticiplePhrase? modifierPresentParticiplePhrase;
  PastParticiplePhrase? modifierPastParticiplePhrase;
  InfinitivePhrase? modifierInfinitivePhrase;
  AdjectiveClause? modifierRelativeClause;

  PrepositionalPhraseModifier({
    this.modifierType,
    this.modifierPrepositionalPhrase,
    this.modifierPresentParticiplePhrase,
    this.modifierPastParticiplePhrase,
    this.modifierInfinitivePhrase,
    this.modifierRelativeClause,
  });

  PrepositionalPhraseModifier copyWith({
    Nullable<PrepositionalPhraseModifierType>? modifierType,
    Nullable<PrepositionalPhrase>? modifierPrepositionalPhrase,
    Nullable<PresentParticiplePhrase>? modifierPresentParticiplePhrase,
    Nullable<PastParticiplePhrase>? modifierPastParticiplePhrase,
    Nullable<InfinitivePhrase>? modifierInfinitivePhrase,
    Nullable<AdjectiveClause>? modifierRelativeClause,
  }) => PrepositionalPhraseModifier(
    modifierType: modifierType == null? this.modifierType : modifierType.value,
    modifierPrepositionalPhrase: modifierPrepositionalPhrase == null? this.modifierPrepositionalPhrase : modifierPrepositionalPhrase.value,
    modifierPresentParticiplePhrase: modifierPresentParticiplePhrase == null? this.modifierPresentParticiplePhrase : modifierPresentParticiplePhrase.value,
    modifierPastParticiplePhrase: modifierPastParticiplePhrase == null? this.modifierPastParticiplePhrase : modifierPastParticiplePhrase.value,
    modifierInfinitivePhrase: modifierInfinitivePhrase == null? this.modifierInfinitivePhrase : modifierInfinitivePhrase.value,
    modifierRelativeClause: modifierRelativeClause == null? this.modifierRelativeClause : modifierRelativeClause.value,
  );

  @override
  String toString() {
    String phrase='';
    if (modifierType==PrepositionalPhraseModifierType.prepositionalPhrase) {
      phrase += (modifierPrepositionalPhrase == null? ' <Prepositional phrase>' : ' $modifierPrepositionalPhrase');
    } else if (modifierType==PrepositionalPhraseModifierType.presentParticiplePhrase) {
      phrase += (modifierPrepositionalPhrase == null? ' <Present participle phrase>' : ' $modifierPrepositionalPhrase');
    } else if (modifierType==PrepositionalPhraseModifierType.pastParticiplePhrase) {
      phrase += (modifierPrepositionalPhrase == null? ' <Past participle phrase>' : ' $modifierPrepositionalPhrase');
    } else if (modifierType==PrepositionalPhraseModifierType.infinitivePhrase) {
      phrase += (modifierPrepositionalPhrase == null? ' <Infinitive phrase>' : ' $modifierPrepositionalPhrase');
    } else if (modifierType==PrepositionalPhraseModifierType.relativeClause) {
      phrase += (modifierPrepositionalPhrase == null? ' <Relative clause>' : ' $modifierPrepositionalPhrase');
    }
    return phrase;
  }
}
