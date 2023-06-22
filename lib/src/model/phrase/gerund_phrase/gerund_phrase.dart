import '../../noun/noun_phrase.dart';
import '../../nullable.dart';
import '../prepositional_phrase/prepositional_phrase.dart';
import 'gerund_phrase_indirect_object_type.dart';
import 'gerund_phrase_object_type.dart';

class GerundPhrase {
  GerundPhrase({
    this.gerundVerb,
    this.directObjectType,
    this.directPronoun,
    this.directOwnName,
    this.directNounPhrase,
    this.directPrepositionalPhrase,
    this.indirectObjectType,
    this.indirectPronoun,
    this.indirectOwnName,
    this.indirectNounPhrase,
    this.modifierAdverb,
  });
  final String? gerundVerb;
  final GerundPhraseObjectType? directObjectType;
  final String? directPronoun;
  final String? directOwnName;
  final NounPhrase? directNounPhrase;
  final PrepositionalPhrase? directPrepositionalPhrase;
  final GerundPhraseIndirectObjectType? indirectObjectType;
  final String? indirectPronoun;
  final String? indirectOwnName;
  final NounPhrase? indirectNounPhrase;
  final String? modifierAdverb;

  GerundPhrase copyWith({
    Nullable<String>? gerundVerb,
    Nullable<GerundPhraseObjectType>? objectType,
    Nullable<String>? objectPronoun,
    Nullable<NounPhrase>? objectNounPhrase,
    Nullable<PrepositionalPhrase>? objectPrepositionalPhrase,
    Nullable<String>? modifierAdverb,
  }) => GerundPhrase(
    gerundVerb: gerundVerb == null? this.gerundVerb : gerundVerb.value,
    directObjectType: objectType == null? this.directObjectType : objectType.value,
    directPronoun: objectPronoun == null? this.directPronoun : objectPronoun.value,
    directNounPhrase: objectNounPhrase == null?
        this.directNounPhrase : objectNounPhrase.value,
    directPrepositionalPhrase: objectPrepositionalPhrase == null?
        this.directPrepositionalPhrase : objectPrepositionalPhrase.value,
    modifierAdverb: modifierAdverb == null?
        this.modifierAdverb : modifierAdverb.value,
  );

  @override
  String toString() {
    String string = gerundVerb == null? ' <Gerund verb>' : ' ${gerundVerb}ing';
    if (directObjectType == GerundPhraseObjectType.pronoun) {
      string += directPronoun == null? ' <Pronoun>' : ' $directPronoun';
    } else if (directObjectType == GerundPhraseObjectType.nounPhrase) {
      string += directNounPhrase == null? ' <Noun phrase>' : ' $directNounPhrase';
    } else if (directObjectType == GerundPhraseObjectType.prepositionalPhrase) {
      string += directPrepositionalPhrase == null? ' <Prepositional phrase>' : ' $directPrepositionalPhrase';
    }
    return string;
  }
}
