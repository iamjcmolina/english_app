import '../../nullable.dart';
import '../adjective/adjective_complement.dart';
import '../adjective/any_adjective.dart';
import '../adverb/any_adverb.dart';
import '../noun/any_noun.dart';
import '../noun/countability.dart';
import '../noun/doer_pronoun.dart';
import '../text_buffer.dart';
import '../verb/any_verb.dart';

class InfinitivePhrase
    implements AnyNoun, AnyAdjective, AnyAdverb, AdjectiveComplement {
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
  @override
  final bool isAllowedInFront = true;
  @override
  final bool isAllowedInTheMiddle = false;
  @override
  final bool isAllowedInTheEnd = true;
  final AnyVerb? verb;
  final AnyNoun? object;
  final AnyAdverb? modifier;

  @override
  String get en {
    TextBuffer buffer = TextBuffer();
    buffer.add('to', disablePrefixWhen: true);
    buffer.add(verb?.infinitive ?? '<InfinitiveVerb>');
    buffer.add(object, when: object != null);
    buffer.add(modifier, when: modifier != null);
    return buffer.toString();
  }

  @override
  String get pluralEs => es;

  @override
  String get singularEs => es;

  @override
  String get es {
    TextBuffer buffer = TextBuffer();
    buffer.add(verb?.infinitiveEs, disablePrefixWhen: true);
    buffer.add(object?.es, when: object != null);
    buffer.add(modifier?.es, when: modifier != null);
    return buffer.toString();
  }

  const InfinitivePhrase({this.verb, this.object, this.modifier});

  InfinitivePhrase copyWith({
    Nullable<AnyVerb>? verb,
    Nullable<AnyNoun>? object,
    Nullable<AnyAdverb>? modifier,
  }) =>
      InfinitivePhrase(
        verb: verb == null ? this.verb : verb.value,
        object: object == null ? this.object : object.value,
        modifier: modifier == null ? this.modifier : modifier.value,
      );

  @override
  String toString() => en;
}
