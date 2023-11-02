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
  final Adverb? modifierAdverb;
  final Adverb? adverb;

  @override
  String get en =>
      TextBuffer().add(modifierAdverb?.en).add(adverb?.en).toString();

  @override
  String get es =>
      TextBuffer().add(modifierAdverb?.es).add(adverb?.es).toString();

  @override
  bool get isValid => modifierAdverb != null && adverb != null;

  const AdverbPlusAdverb({this.modifierAdverb, this.adverb});

  AdverbPlusAdverb copyWith({
    Nullable<Adverb>? intensifierOrMitigatorAdverb,
    Nullable<Adverb>? adverb,
  }) =>
      AdverbPlusAdverb(
        modifierAdverb: intensifierOrMitigatorAdverb == null
            ? this.modifierAdverb
            : intensifierOrMitigatorAdverb.value,
        adverb: adverb == null ? this.adverb : adverb.value,
      );

  @override
  String toString() => en;
}
