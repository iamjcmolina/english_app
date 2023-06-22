import '../../adverb/adverb_type.dart';
import '../../noun/noun_phrase.dart';
import 'prepositional_phrase.dart';

class PrepositionalPhraseWithNounPhraseObject extends PrepositionalPhrase {
  NounPhrase nounPhrase;

  PrepositionalPhraseWithNounPhraseObject({
    required super.preposition,
    required this.nounPhrase,
  });

  @override
  // TODO: implement adverbType, it can be: place, time
  AdverbType get adverbType => throw UnimplementedError();

  @override
  String toString() => '$preposition $nounPhrase';
}
