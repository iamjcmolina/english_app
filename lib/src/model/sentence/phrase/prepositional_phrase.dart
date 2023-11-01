import '../../nullable.dart';
import '../adjective/adjective_complement.dart';
import '../adjective/any_adjective.dart';
import '../adverb/any_adverb.dart';
import '../noun/any_noun.dart';
import '../preposition/preposition.dart';
import '../text_buffer.dart';

class PrepositionalPhrase
    implements AnyAdjective, AnyAdverb, AdjectiveComplement {
  @override
  final bool isAllowedInFront = true;
  @override
  final bool isAllowedInTheMiddle = false;
  @override
  final bool isAllowedInTheEnd = true;
  final Preposition? preposition;
  final AnyNoun? object;

  @override
  String get en {
    TextBuffer buffer = TextBuffer();
    buffer.add(preposition?.en, disablePrefixWhen: true);
    buffer.add(object?.en, when: object != null);
    return buffer.toString();
  }

  @override
  String get es {
    TextBuffer buffer = TextBuffer();
    buffer.add(preposition?.es, disablePrefixWhen: true);
    buffer.add(object?.es, when: object != null);
    return buffer.toString();
  }

  @override
  String get pluralEs => es;

  @override
  String get singularEs => es;

  const PrepositionalPhrase({this.preposition, this.object});

  PrepositionalPhrase copyWith({
    Nullable<Preposition>? preposition,
    Nullable<AnyNoun>? object,
  }) =>
      PrepositionalPhrase(
        preposition: preposition == null ? this.preposition : preposition.value,
        object: object == null ? this.object : object.value,
      );

  @override
  String toString() => en;
}
