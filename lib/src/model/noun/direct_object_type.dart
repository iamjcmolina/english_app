enum DirectObjectType {
  pronoun("Pronoun"),
  ownName("Own Name"),
  nounPhrase("Noun Phrase"),
  gerundPhrase("Gerund Phrase"),
  infinitivePhrase("Infinitive Phrase"),
  adjectiveClause("Adjective Clause");

  final String name;

  const DirectObjectType(this.name);
}
