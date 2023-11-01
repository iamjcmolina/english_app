import '../../nullable.dart';
import '../adjective/adjective.dart';
import '../adjective/adjective_complement.dart';
import '../adjective/any_adjective.dart';
import '../text_buffer.dart';

class AdjectivePlusComplement extends AnyAdjective {
  final Adjective? adjective;
  final AdjectiveComplement? complement;

  @override
  String get en =>
      TextBuffer().add(adjective?.en).add(complement?.en).toString();

  @override
  String get pluralEs =>
      TextBuffer().add(adjective?.pluralEs).add(complement?.es).toString();

  @override
  String get singularEs =>
      TextBuffer().add(adjective?.singularEs).add(complement?.es).toString();

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
  String toString() => en;
}
