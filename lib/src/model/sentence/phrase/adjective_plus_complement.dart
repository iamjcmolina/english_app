import '../../nullable.dart';
import '../adjective/adjective.dart';
import '../adjective/adjective_complement.dart';
import '../adjective/any_adjective.dart';
import '../text_buffer.dart';

class AdjectivePlusComplement implements AnyAdjective {
  final Adjective? adjective;
  final AdjectiveComplement? complement;

  @override
  String get en =>
      TextBuffer().add(adjective?.en).add(complement?.en).toString();

  @override
  bool get isValid => adjective != null && complement != null;

  const AdjectivePlusComplement({this.adjective, this.complement});

  AdjectivePlusComplement copyWith({
    Nullable<Adjective>? adjective,
    Nullable<AdjectiveComplement>? complement,
  }) =>
      AdjectivePlusComplement(
        adjective: adjective == null ? this.adjective : adjective.value,
        complement: complement == null ? this.complement : complement.value,
      );

  @override
  String toEs([bool? isPluralSubject]) => TextBuffer()
      .add(adjective?.toEs(isPluralSubject))
      .add(complement?.es)
      .toString();
}
