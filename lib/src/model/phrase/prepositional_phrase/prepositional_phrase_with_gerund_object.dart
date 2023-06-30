import '../../adverb/adverb_type.dart';
import '../../verb/verb.dart';
import 'prepositional_phrase.dart';

class PrepositionalPhraseWithGerundObject extends PrepositionalPhrase {
  Verb verb;

  PrepositionalPhraseWithGerundObject({
    required super.preposition,
    required this.verb,
  });

  @override
  // TODO: implement adverbType, it can be: place, time
  AdverbType get adverbType => throw UnimplementedError();

  @override
  String toString() => '$preposition ${verb.presentParticiple}';
}
