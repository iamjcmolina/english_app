import '../phrase/gerund_phrase.dart';
import '../phrase/infinitive_phrase.dart';
import '../phrase/noun_phrase.dart';
import 'indefinite_pronoun.dart';
import 'object_pronoun.dart';

enum ObjectType {
  pronoun("Object Pronoun"),
  indefinitePronoun("Indefinite pronoun"),
  nounPhrase("Noun Phrase"),
  infinitivePhrase("Infinitive Phrase"),
  gerundPhrase("Gerund Phrase");

  final String name;

  const ObjectType(this.name);

  static ObjectType from(Type type, ObjectType defaultType) => switch (type) {
        ObjectPronoun => ObjectType.pronoun,
        IndefinitePronoun => ObjectType.indefinitePronoun,
        NounPhrase => ObjectType.nounPhrase,
        InfinitivePhrase => ObjectType.infinitivePhrase,
        GerundPhrase => ObjectType.gerundPhrase,
        _ => defaultType,
      };
}
