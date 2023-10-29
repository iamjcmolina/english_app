enum ComplementType {
  possessivePronoun('Possessive pronoun'),
  nounPhrase('Noun phrase'),
  nounClause('Noun clause'),
  adjective('Adjective'),
  prepositionalPhrase('Prepositional phrase');

  final String name;

  const ComplementType(this.name);
}
