enum AdverbialPhraseType {
  word('Adverb Word'),
  adverbPlusAdverb('Intensifier/Mitigator + Adverb'),
  infinitivePhrase('Infinitive Phrase'),
  prepositionalPhrase('Prepositional Phrase');

  final String name;

  const AdverbialPhraseType(this.name);
}
