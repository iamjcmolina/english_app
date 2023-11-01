import '../../nullable.dart';
import '../adjective/any_adjective.dart';
import '../adverb/any_adverb.dart';
import '../noun/any_noun.dart';
import '../text_buffer.dart';
import '../verb/any_verb.dart';

class PresentParticiplePhrase implements AnyAdjective {
  final AnyVerb? verb;
  final AnyNoun? object;
  final AnyAdverb? modifier;

  @override
  String get en {
    TextBuffer buffer = TextBuffer();
    buffer.add(verb?.progressive ?? '<ProgressiveVerb>',
        disablePrefixWhen: true);
    buffer.add(object, when: object != null);
    buffer.add(modifier, when: modifier != null);
    return buffer.toString();
  }

  @override
  String get es {
    TextBuffer buffer = TextBuffer();
    buffer.add(verb?.pastParticipleEs, disablePrefixWhen: true);
    buffer.add(object?.es, when: object != null);
    buffer.add(modifier?.es, when: modifier != null);
    return buffer.toString();
  }

  @override
  String get pluralEs => es;

  @override
  String get singularEs => es;

  const PresentParticiplePhrase({
    this.verb,
    this.object,
    this.modifier,
  });

  PresentParticiplePhrase copyWith({
    Nullable<AnyVerb>? verb,
    Nullable<AnyNoun>? object,
    Nullable<AnyAdverb>? modifier,
  }) =>
      PresentParticiplePhrase(
        verb: verb == null ? this.verb : verb.value,
        object: object == null ? this.object : object.value,
        modifier: modifier == null ? this.modifier : modifier.value,
      );

  @override
  String toString() => en;
}
