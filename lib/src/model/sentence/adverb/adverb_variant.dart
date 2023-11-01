enum AdverbVariant {
  word('Adverb Word'),
  adverbPlusAdverb('Adverb + Adverb Phrase'),
  infinitivePhrase('Infinitive Phrase'),
  prepositionalPhrase('Prepositional Phrase');

  final String name;

  const AdverbVariant(this.name);
}
