import '../../nullable.dart';
import '../adjective/phrasal_attributive.dart';
import '../adverb/any_adverb.dart';
import '../noun/any_noun.dart';
import '../text_buffer.dart';
import '../verb/any_verb.dart';

class PresentParticiplePhrase extends PhrasalAttributive {
  final AnyVerb? verb;
  final AnyNoun? object;
  final AnyAdverb? adverb;

  @override
  String get en => TextBuffer()
      .add(verb?.progressive)
      .add(object?.en)
      .add(adverb?.en)
      .toString();

  @override
  String get es => TextBuffer()
      .add(verb?.pastParticipleEs)
      .add(object?.es)
      .add(adverb?.es)
      .toString();

  @override
  bool get isValid => verb != null && (object != null || adverb != null);

  const PresentParticiplePhrase({
    this.verb,
    this.object,
    this.adverb,
  });

  PresentParticiplePhrase copyWith({
    Nullable<AnyVerb>? verb,
    Nullable<AnyNoun>? object,
    Nullable<AnyAdverb>? adverb,
  }) =>
      PresentParticiplePhrase(
        verb: verb == null ? this.verb : verb.value,
        object: object == null ? this.object : object.value,
        adverb: adverb == null ? this.adverb : adverb.value,
      );
}
