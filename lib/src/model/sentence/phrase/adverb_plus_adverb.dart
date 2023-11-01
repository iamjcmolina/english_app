import '../../nullable.dart';
import '../adverb/adverb.dart';
import '../adverb/any_adverb.dart';
import '../text_buffer.dart';

class AdverbPlusAdverb implements AnyAdverb {
  @override
  final bool isAllowedInFront = false;
  @override
  final bool isAllowedInTheMiddle = false;
  @override
  final bool isAllowedInTheEnd = false;
  final Adverb? intensifierOrMitigatorAdverb;
  final Adverb? adverb;

  @override
  String get en => TextBuffer()
      .add(intensifierOrMitigatorAdverb?.en)
      .add(adverb?.en)
      .toString();

  @override
  String get es => TextBuffer()
      .add(intensifierOrMitigatorAdverb?.es)
      .add(adverb?.es)
      .toString();

  const AdverbPlusAdverb({this.intensifierOrMitigatorAdverb, this.adverb});

  AdverbPlusAdverb copyWith({
    Nullable<Adverb>? intensifierOrMitigatorAdverb,
    Nullable<Adverb>? adverb,
  }) =>
      AdverbPlusAdverb(
        intensifierOrMitigatorAdverb: intensifierOrMitigatorAdverb == null
            ? this.intensifierOrMitigatorAdverb
            : intensifierOrMitigatorAdverb.value,
        adverb: adverb == null ? this.adverb : adverb.value,
      );

  @override
  String toString() => en;
}
