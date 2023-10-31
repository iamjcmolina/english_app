import '../../nullable.dart';
import '../adverb/adverb.dart';
import '../adverb/any_adverb.dart';
import '../sentence_buffer.dart';

class AdverbPlusAdverb implements AnyAdverb {
  @override
  final bool isAllowedInFront = false;
  @override
  final bool isAllowedInTheMiddle = false;
  @override
  final bool isAllowedInTheEnd = false;
  final Adverb? modifier;
  final Adverb? regularAdverb;

  @override
  String get en {
    SentenceBuffer buffer = SentenceBuffer();
    buffer.add(modifier?.en ?? '<IntensifierOrMitigatorAdverb>',
        disablePrefixWhen: true);
    buffer.add(regularAdverb?.en ?? '<RegularAdverb>');
    return buffer.toString();
  }

  @override
  String get es {
    SentenceBuffer buffer = SentenceBuffer();
    buffer.add(modifier?.es ?? '<AdverbioIntensificadorOMitigador>',
        disablePrefixWhen: true);
    buffer.add(regularAdverb?.es ?? '<AdverbioRegular>');
    return buffer.toString();
  }

  const AdverbPlusAdverb({this.modifier, this.regularAdverb});

  AdverbPlusAdverb copyWith({
    Nullable<Adverb>? modifier,
    Nullable<Adverb>? regularAdverb,
  }) =>
      AdverbPlusAdverb(
        modifier: modifier == null ? this.modifier : modifier.value,
        regularAdverb:
            regularAdverb == null ? this.regularAdverb : regularAdverb.value,
      );

  @override
  String toString() => en;
}
