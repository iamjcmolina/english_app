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
  final Adverb? degreeAdverb;
  final Adverb? adverb;

  @override
  String get en =>
      TextBuffer().add(degreeAdverb?.en).add(adverb?.en).toString();

  @override
  String get es =>
      TextBuffer().add(degreeAdverb?.es).add(adverb?.es).toString();

  @override
  bool get isValid => degreeAdverb != null && adverb != null;

  const AdverbPlusAdverb({this.degreeAdverb, this.adverb});

  AdverbPlusAdverb copyWith({
    Nullable<Adverb>? degreeAdverb,
    Nullable<Adverb>? adverb,
  }) =>
      AdverbPlusAdverb(
        degreeAdverb:
            degreeAdverb == null ? this.degreeAdverb : degreeAdverb.value,
        adverb: adverb == null ? this.adverb : adverb.value,
      );
}
