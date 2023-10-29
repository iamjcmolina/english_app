enum ComplementType {
  adjective('Adjective'),
  possessivePronoun('Possessive pronoun'),
  nounPhrase('Noun phrase'),
  infinitivePhrase('Infinitive phrase');
  //prepositionalPhrase('Prepositional phrase');
  //nounClause('Noun clause');

  final String name;

  const ComplementType(this.name);
}
