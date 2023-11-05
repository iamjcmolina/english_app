import '../../nullable.dart';
import '../adjective/adjective_complement.dart';
import '../adjective/any_adjective.dart';
import '../adverb/any_adverb.dart';
import '../noun/any_noun.dart';
import '../noun/countability.dart';
import '../noun/doer.dart';
import '../text_buffer.dart';
import '../verb/any_verb.dart';

class InfinitivePhrase
    implements AnyNoun, AnyAdjective, AnyAdverb, AdjectiveComplement {
  @override
  final Doer asDoer = Doer.it;
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
  @override
  final bool isAllowedInFront = true;
  @override
  final bool isAllowedInTheMiddle = false;
  @override
  final bool isAllowedInTheEnd = true;
  final AnyVerb? verb;
  final AnyNoun? object;
  final AnyAdverb? adverb;

  @override
  String get en => TextBuffer()
      .add('to')
      .add(verb?.infinitive)
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
  String get pluralEs => es;

  @override
  String get singularEs => es;

  @override
  Doer get asDoerEs => asDoer;

  @override
  bool get isValid => verb != null && (object != null || adverb != null);

  const InfinitivePhrase({this.verb, this.object, this.adverb});

  InfinitivePhrase copyWith({
    Nullable<AnyVerb>? verb,
    Nullable<AnyNoun>? object,
    Nullable<AnyAdverb>? adverb,
  }) =>
      InfinitivePhrase(
        verb: verb == null ? this.verb : verb.value,
        object: object == null ? this.object : object.value,
        adverb: adverb == null ? this.adverb : adverb.value,
      );
}
