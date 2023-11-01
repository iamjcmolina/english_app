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
}
