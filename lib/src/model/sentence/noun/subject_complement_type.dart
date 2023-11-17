import '../adjective/adjective.dart';
import '../phrase/adjective_plus_complement.dart';
import '../phrase/adverb_plus_adjective.dart';
import '../phrase/infinitive_phrase.dart';
import '../phrase/noun_phrase.dart';
import 'possessive_pronoun.dart';

enum SubjectComplementType {
  adjective('Adjective'),
  degreeAdverbPlusAdjective('Degree Adverb + Adjective'),
  adjectivePlusComplement('Adjective + Complement'),
  possessivePronoun('Possessive pronoun'),
  nounPhrase('Noun phrase'),
  infinitivePhrase('Infinitive phrase');
  //prepositionalPhrase('Prepositional phrase');
  //nounClause('Noun clause');

  final String name;

  const SubjectComplementType(this.name);

  static SubjectComplementType from(
          Type type, SubjectComplementType defaultType) =>
      switch (type) {
        Adjective => SubjectComplementType.adjective,
        AdverbPlusAdjective => SubjectComplementType.degreeAdverbPlusAdjective,
        AdjectivePlusComplement =>
          SubjectComplementType.adjectivePlusComplement,
        PossessivePronoun => SubjectComplementType.possessivePronoun,
        NounPhrase => SubjectComplementType.nounPhrase,
        InfinitivePhrase => SubjectComplementType.infinitivePhrase,
        _ => defaultType,
      };
}
