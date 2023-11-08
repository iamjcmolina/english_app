import '../phrase/adjective_plus_complement.dart';
import '../phrase/adverb_plus_adjective.dart';
import '../phrase/infinitive_phrase.dart';
import '../phrase/past_participle_phrase.dart';
import '../phrase/prepositional_phrase.dart';
import '../phrase/present_participle_phrase.dart';

enum AdjectivalPhraseType {
  degreeAdverbPlusAdjective('Degree Adverb + Adjective'),
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
        AdverbPlusAdjective => AdjectivalPhraseType.degreeAdverbPlusAdjective,
        AdjectivePlusComplement => AdjectivalPhraseType.adjectivePlusComplement,
        PrepositionalPhrase => AdjectivalPhraseType.prepositionalPhrase,
        PresentParticiplePhrase => AdjectivalPhraseType.presentParticiplePhrase,
        PastParticiplePhrase => AdjectivalPhraseType.pastParticiplePhrase,
        InfinitivePhrase => AdjectivalPhraseType.infinitivePhrase,
        _ => defaultType,
      };
}
