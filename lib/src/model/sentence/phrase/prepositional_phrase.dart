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
  String get en => TextBuffer().add(preposition?.en).add(object?.en).toString();

  @override
  String get es => TextBuffer().add(preposition?.es).add(object?.es).toString();

  @override
  String get pluralEs => es;

  @override
  String get singularEs => es;

  @override
  bool get isValid => preposition != null && object != null;

  const PrepositionalPhrase({this.preposition, this.object});

  PrepositionalPhrase copyWith({
    Nullable<Preposition>? preposition,
    Nullable<AnyNoun>? object,
  }) =>
      PrepositionalPhrase(
        preposition: preposition == null ? this.preposition : preposition.value,
        object: object == null ? this.object : object.value,
      );
}
