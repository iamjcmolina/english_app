import '../../nullable.dart';
import '../adjective/any_adjective.dart';
import '../adverb/any_adverb.dart';
import '../sentence_buffer.dart';
import '../verb/any_verb.dart';

class PastParticiplePhrase implements AnyAdjective {
  final AnyVerb? verb;
  final AnyAdverb? modifier;

  @override
  String get en {
    SentenceBuffer buffer = SentenceBuffer();
    buffer.add(verb?.pastParticiple, disablePrefixWhen: true);
    buffer.add(modifier);
    return buffer.toString();
  }

  String get es {
    SentenceBuffer buffer = SentenceBuffer();
    buffer.add(verb?.pastParticipleEs, disablePrefixWhen: true);
    buffer.add(modifier?.es);
    return buffer.toString();
  }

  @override
  String get pluralEs => es;

  @override
  String get singularEs => es;

  const PastParticiplePhrase({this.verb, this.modifier});

  PastParticiplePhrase copyWith({
    Nullable<AnyVerb>? verb,
    Nullable<AnyAdverb>? modifier,
  }) =>
      PastParticiplePhrase(
        verb: verb == null ? this.verb : verb.value,
        modifier: modifier == null ? this.modifier : modifier.value,
      );

  @override
  String toString() => en;
}
