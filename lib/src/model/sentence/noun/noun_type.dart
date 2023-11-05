import '../phrase/gerund_phrase.dart';
import '../phrase/infinitive_phrase.dart';
import '../phrase/noun_phrase.dart';
import 'indefinite_pronoun.dart';
import 'pronoun.dart';

enum NounType {
  pronoun("Pronoun"),
  indefinitePronoun("Indefinite pronoun"),
  nounPhrase("Noun Phrase"),
  infinitivePhrase("Infinitive Phrase"),
  gerundPhrase("Gerund Phrase");

  final String name;

  const NounType(this.name);

  static NounType from(Type type, NounType defaultType) => switch (type) {
        Pronoun => NounType.pronoun,
        IndefinitePronoun => NounType.indefinitePronoun,
        NounPhrase => NounType.nounPhrase,
        InfinitivePhrase => NounType.infinitivePhrase,
        GerundPhrase => NounType.gerundPhrase,
        _ => defaultType,
      };
}
