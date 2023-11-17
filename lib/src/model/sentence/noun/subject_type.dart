import '../phrase/gerund_phrase.dart';
import '../phrase/infinitive_phrase.dart';
import '../phrase/noun_phrase.dart';
import 'indefinite_pronoun.dart';
import 'subject_pronoun.dart';

enum SubjectType {
  pronoun("Subject Pronoun"),
  indefinitePronoun("Indefinite pronoun"),
  nounPhrase("Noun Phrase"),
  infinitivePhrase("Infinitive Phrase"),
  gerundPhrase("Gerund Phrase");

  final String name;

  const SubjectType(this.name);

  static SubjectType from(Type type, SubjectType defaultType) => switch (type) {
        SubjectPronoun => SubjectType.pronoun,
        IndefinitePronoun => SubjectType.indefinitePronoun,
        NounPhrase => SubjectType.nounPhrase,
        InfinitivePhrase => SubjectType.infinitivePhrase,
        GerundPhrase => SubjectType.gerundPhrase,
        _ => defaultType,
      };
}
