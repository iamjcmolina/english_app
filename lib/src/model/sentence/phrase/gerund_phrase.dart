import '../../nullable.dart';
import '../adverb/any_adverb.dart';
import '../noun/any_noun.dart';
import '../sentence_buffer.dart';
import '../verb/any_verb.dart';

class GerundPhrase implements AnyNoun {
  @override
  final DoerPronoun asPronoun = DoerPronoun.it;
  @override
  final Countability countability = Countability.singular;
  @override
  final bool isPlural = false;
  @override
  final bool isSingular = true;
  @override
  final bool isSingularFirstPerson = false;
  @override
  final bool isSingularThirdPerson = true;
  @override
  final bool isUncountable = false;
  final AnyVerb? verb;
  final AnyNoun? object;
  final AnyAdverb? modifier;

  @override
  String get en {
    SentenceBuffer buffer = SentenceBuffer();
    buffer.add(verb?.progressive ?? '<ProgressiveVerb>',
        disablePrefixWhen: true);
    buffer.add(object, when: object != null);
    buffer.add(modifier, when: modifier != null);
    return buffer.toString();
  }

  @override
  String get es {
    SentenceBuffer buffer = SentenceBuffer();
    buffer.add(verb?.infinitiveEs, disablePrefixWhen: true);
    buffer.add(object?.es, when: object != null);
    buffer.add(modifier?.es, when: modifier != null);
    return buffer.toString();
  }

  const GerundPhrase({this.verb, this.object, this.modifier});

  GerundPhrase copyWith({
    Nullable<AnyVerb>? verb,
    Nullable<AnyNoun>? object,
    Nullable<AnyAdverb>? modifier,
  }) =>
      GerundPhrase(
        verb: verb == null ? this.verb : verb.value,
        object: object == null ? this.object : object.value,
        modifier: modifier == null ? this.modifier : modifier.value,
      );

  @override
  String toString() => en;
}
