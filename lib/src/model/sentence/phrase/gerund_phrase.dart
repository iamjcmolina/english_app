import '../../nullable.dart';
import '../adverb/any_adverb.dart';
import '../noun/any_noun.dart';
import '../noun/countability.dart';
import '../noun/doer_pronoun.dart';
import '../text_buffer.dart';
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
  final AnyAdverb? adverb;

  @override
  String get en => TextBuffer()
      .add(verb?.progressive)
      .add(object?.en)
      .add(adverb?.en)
      .toString();

  @override
  String get es => TextBuffer()
      .add(verb?.infinitiveEs)
      .add(object?.es)
      .add(adverb?.es)
      .toString();

  @override
  bool get isValid => verb != null && (object != null || adverb != null);

  const GerundPhrase({this.verb, this.object, this.adverb});

  GerundPhrase copyWith({
    Nullable<AnyVerb>? verb,
    Nullable<AnyNoun>? object,
    Nullable<AnyAdverb>? adverb,
  }) =>
      GerundPhrase(
        verb: verb == null ? this.verb : verb.value,
        object: object == null ? this.object : object.value,
        adverb: adverb == null ? this.adverb : adverb.value,
      );

  @override
  String toString() => en;
}
