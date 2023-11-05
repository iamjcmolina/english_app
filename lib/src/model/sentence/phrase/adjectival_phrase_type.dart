import 'adjective_plus_complement.dart';
import 'adverb_plus_adjective.dart';
import 'infinitive_phrase.dart';
import 'past_participle_phrase.dart';
import 'prepositional_phrase.dart';
import 'present_participle_phrase.dart';

enum AdjectivalPhraseType {
  adverbPlusAdjective('Adverb + Adjective'),
  adjectivePlusComplement('Adjective + Complement'),
  prepositionalPhrase('Prepositional Phrase'),
  presentParticiplePhrase('Present Participle Phrase'),
  pastParticiplePhrase('Past Participle Phrase'),
  infinitivePhrase('Infinitive Phrase');
  //relativeClause('Distributive');

  final String name;

  const AdjectivalPhraseType(this.name);

  static AdjectivalPhraseType from(
          Type type, AdjectivalPhraseType defaultType) =>
      switch (type) {
        AdverbPlusAdjective => AdjectivalPhraseType.adverbPlusAdjective,
        AdjectivePlusComplement => AdjectivalPhraseType.adjectivePlusComplement,
        PrepositionalPhrase => AdjectivalPhraseType.prepositionalPhrase,
        PresentParticiplePhrase => AdjectivalPhraseType.presentParticiplePhrase,
        PastParticiplePhrase => AdjectivalPhraseType.pastParticiplePhrase,
        InfinitivePhrase => AdjectivalPhraseType.infinitivePhrase,
        _ => defaultType,
      };
}
