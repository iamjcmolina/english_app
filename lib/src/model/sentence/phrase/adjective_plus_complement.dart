import '../../nullable.dart';
import '../adjective/adjective.dart';
import '../adjective/any_adjective.dart';
import '../sentence_buffer.dart';
import 'adjective_complement.dart';

class AdjectivePlusComplement extends AnyAdjective {
  final Adjective? adjective;
  final AdjectiveComplement? complement;

  @override
  String get en {
    SentenceBuffer buffer = SentenceBuffer();
    buffer.add(adjective?.en ?? '<Adjective>', disablePrefixWhen: true);
    buffer.add(complement?.en ?? '<AdjectiveComplement>');
    return buffer.toString();
  }

  @override
  String get pluralEs {
    SentenceBuffer buffer = SentenceBuffer();
    buffer.add(adjective?.pluralEs ?? '<Adjetivo>', disablePrefixWhen: true);
    buffer.add(complement?.es ?? '<ComplementoDelAdjetivo>');
    return buffer.toString();
  }

  @override
  String get singularEs {
    SentenceBuffer buffer = SentenceBuffer();
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
