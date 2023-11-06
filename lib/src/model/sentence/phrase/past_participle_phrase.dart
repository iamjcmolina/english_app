import '../../nullable.dart';
import '../adjective/any_adjective.dart';
import '../adverb/any_adverb.dart';
import '../text_buffer.dart';
import '../verb/any_verb.dart';

class PastParticiplePhrase implements AnyAdjective {
  final AnyVerb? verb;
  final AnyAdverb? adverb;

  @override
  String get en =>
      TextBuffer().add(verb?.pastParticiple).add(adverb?.en).toString();

  @override
  bool get isValid => verb != null && adverb != null;

  const PastParticiplePhrase({this.verb, this.adverb});

  PastParticiplePhrase copyWith({
    Nullable<AnyVerb>? verb,
    Nullable<AnyAdverb>? adverb,
  }) =>
      PastParticiplePhrase(
        verb: verb == null ? this.verb : verb.value,
        adverb: adverb == null ? this.adverb : adverb.value,
      );

  @override
  String toEs([bool? isPluralSubject]) =>
      TextBuffer().add(verb?.pastParticipleEs).add(adverb?.es).toString();
}
