import '../phrase/adverb_plus_adverb.dart';
import '../phrase/infinitive_phrase.dart';
import '../phrase/prepositional_phrase.dart';
import 'adverb.dart';

enum AdverbialPhraseType {
  adverb('Adverb Word'),
  adverbPlusAdverb('Intensifier/Mitigator + Adverb'),
  infinitivePhrase('Infinitive Phrase'),
  prepositionalPhrase('Prepositional Phrase');

  final String name;

  const AdverbialPhraseType(this.name);

  static AdverbialPhraseType from(Type type, AdverbialPhraseType defaultType) =>
      switch (type) {
        Adverb => AdverbialPhraseType.adverb,
        AdverbPlusAdverb => AdverbialPhraseType.adverbPlusAdverb,
        InfinitivePhrase => AdverbialPhraseType.infinitivePhrase,
        PrepositionalPhrase => AdverbialPhraseType.prepositionalPhrase,
        _ => defaultType,
      };
}
