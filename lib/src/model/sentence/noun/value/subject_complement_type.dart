enum SubjectComplementType {
  adjective('Adjective'),
  adverbPlusAdjective('Adverb+Adjective'),
  adjectivePlusComplement('Adjective+Complement'),
  possessivePronoun('Possessive pronoun'),
  nounPhrase('Noun phrase'),
  infinitivePhrase('Infinitive phrase');
  //prepositionalPhrase('Prepositional phrase');
  //nounClause('Noun clause');

  final String name;

  const SubjectComplementType(this.name);
}
