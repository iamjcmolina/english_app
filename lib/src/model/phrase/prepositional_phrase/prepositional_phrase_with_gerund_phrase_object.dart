import '../../adverb/adverb_type.dart';
import '../gerund_phrase/gerund_phrase.dart';
import 'prepositional_phrase.dart';

class PrepositionalPhraseWithGerundPhraseObject extends PrepositionalPhrase {
  GerundPhrase gerundPhrase;

  PrepositionalPhraseWithGerundPhraseObject({
    required super.preposition,
    required this.gerundPhrase,
  });

  @override
  // TODO: implement adverbType, it can be: place, time
  AdverbType get adverbType => throw UnimplementedError();

  @override
  String toString() => '$preposition $gerundPhrase';
}
