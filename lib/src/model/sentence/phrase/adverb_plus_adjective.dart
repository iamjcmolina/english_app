import '../../nullable.dart';
import '../adjective/adjective.dart';
import '../adjective/any_adjective.dart';
import '../adverb/adverb.dart';
import '../sentence_buffer.dart';

class AdverbPlusAdjective extends AnyAdjective {
  final Adverb? adverb;
  final Adjective? adjective;

  @override
  String get en {
    SentenceBuffer buffer = SentenceBuffer();
    buffer.add(adverb?.en ?? '<Adverb>', disablePrefixWhen: true);
    buffer.add(adjective?.en ?? '<Adjective>');
    return buffer.toString();
  }

  @override
  String get pluralEs {
    SentenceBuffer buffer = SentenceBuffer();
    buffer.add(adverb?.es ?? '<Adverbio>', disablePrefixWhen: true);
    buffer.add(adjective?.pluralEs ?? '<Adjetivo>');
    return buffer.toString();
  }

  @override
  String get singularEs {
    SentenceBuffer buffer = SentenceBuffer();
    buffer.add(adverb?.es ?? '<Adverbio>', disablePrefixWhen: true);
    buffer.add(adjective?.singularEs ?? '<Adjetivo>');
    return buffer.toString();
  }

  const AdverbPlusAdjective({this.adjective, this.adverb});

  AdverbPlusAdjective copyWith({
    Nullable<Adverb>? adverb,
    Nullable<Adjective>? adjective,
  }) =>
      AdverbPlusAdjective(
        adverb: adverb == null ? this.adverb : adverb.value,
        adjective: adjective == null ? this.adjective : adjective.value,
      );

  @override
  String toString() => en;
}
