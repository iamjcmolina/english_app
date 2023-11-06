import '../../nullable.dart';
import '../adjective/phrasal_attributive.dart';
import '../adverb/any_adverb.dart';
import '../text_buffer.dart';
import '../verb/any_verb.dart';

class PastParticiplePhrase extends PhrasalAttributive {
  final AnyVerb? verb;
  final AnyAdverb? adverb;

  @override
  String get en =>
      TextBuffer().add(verb?.pastParticiple).add(adverb?.en).toString();

  @override
  String get es =>
      TextBuffer().add(verb?.pastParticipleEs).add(adverb?.es).toString();

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
}
