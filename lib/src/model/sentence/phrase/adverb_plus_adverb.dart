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
  final Adverb? intensifierAdverb;
  final Adverb? adverb;

  @override
  String get en =>
      TextBuffer().add(intensifierAdverb?.en).add(adverb?.en).toString();

  @override
  String get es =>
      TextBuffer().add(intensifierAdverb?.es).add(adverb?.es).toString();

  @override
  bool get isValid => intensifierAdverb != null && adverb != null;

  const AdverbPlusAdverb({this.intensifierAdverb, this.adverb});

  AdverbPlusAdverb copyWith({
    Nullable<Adverb>? intensifierAdverb,
    Nullable<Adverb>? adverb,
  }) =>
      AdverbPlusAdverb(
        intensifierAdverb: intensifierAdverb == null
            ? this.intensifierAdverb
            : intensifierAdverb.value,
        adverb: adverb == null ? this.adverb : adverb.value,
      );
}
