enum DeterminerType {
  article('Article'),
  possessive('Possessive'),
  demonstrative('Demonstrative'),
  distributive('Distributive'),
  quantifier('Quantifier'),
  number('Number');

  final String name;

  const DeterminerType(this.name);
}
