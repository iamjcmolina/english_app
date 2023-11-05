import '../noun/indefinite_pronoun.dart';
import '../phrase/prepositional_phrase.dart';

enum AdjectiveComplementType {
  prepositionalPhrase('Article'),
  infinitivePhrase('Possessive');
  // nounClause('Demonstrative');

  final String name;

  const AdjectiveComplementType(this.name);

  static AdjectiveComplementType from(
          Type type, AdjectiveComplementType defaultType) =>
      switch (type) {
        PrepositionalPhrase => AdjectiveComplementType.prepositionalPhrase,
        IndefinitePronoun => AdjectiveComplementType.infinitivePhrase,
        _ => defaultType,
      };
}
