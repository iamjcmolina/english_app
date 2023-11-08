import '../../nullable.dart';
import '../adjective/adjective.dart';
import '../adjective/any_adjective.dart';
import '../adverb/adverb.dart';
import '../text_buffer.dart';

class AdverbPlusAdjective implements AnyAdjective {
  final Adverb? degreeAdverb;
  final Adjective? adjective;

  @override
  String get en =>
      TextBuffer().add(degreeAdverb?.en).add(adjective?.en).toString();

  @override
  bool get isValid => degreeAdverb != null && adjective != null;

  const AdverbPlusAdjective({this.adjective, this.degreeAdverb});

  AdverbPlusAdjective copyWith({
    Nullable<Adverb>? degreeAdverb,
    Nullable<Adjective>? adjective,
  }) =>
      AdverbPlusAdjective(
        degreeAdverb:
            degreeAdverb == null ? this.degreeAdverb : degreeAdverb.value,
        adjective: adjective == null ? this.adjective : adjective.value,
      );

  @override
  String toEs([bool? isPluralSubject]) => TextBuffer()
      .add(degreeAdverb?.es)
      .add(adjective?.toEs(isPluralSubject))
      .toString();
}
