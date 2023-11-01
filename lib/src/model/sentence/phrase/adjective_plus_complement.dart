import '../../nullable.dart';
import '../adjective/adjective.dart';
import '../adjective/adjective_complement.dart';
import '../adjective/any_adjective.dart';
import '../text_buffer.dart';

class AdjectivePlusComplement extends AnyAdjective {
  final Adjective? adjective;
  final AdjectiveComplement? complement;

  @override
  String get en {
    TextBuffer buffer = TextBuffer();
    buffer.add(adjective?.en ?? '<Adjective>', disablePrefixWhen: true);
    buffer.add(complement?.en ?? '<AdjectiveComplement>');
    return buffer.toString();
  }

  @override
  String get pluralEs {
    TextBuffer buffer = TextBuffer();
    buffer.add(adjective?.pluralEs ?? '<Adjetivo>', disablePrefixWhen: true);
    buffer.add(complement?.es ?? '<ComplementoDelAdjetivo>');
    return buffer.toString();
  }

  @override
  String get singularEs {
    TextBuffer buffer = TextBuffer();
    buffer.add(adjective?.singularEs ?? '<Adjetivo>', disablePrefixWhen: true);
    buffer.add(complement?.es ?? '<ComplementoDelAdjetivo>');
    return buffer.toString();
  }

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
