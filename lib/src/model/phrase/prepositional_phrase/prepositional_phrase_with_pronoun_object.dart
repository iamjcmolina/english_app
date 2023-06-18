import '../../adverb/adverb_type.dart';
import 'prepositional_phrase.dart';

class PrepositionalPhraseWithPronounObject extends PrepositionalPhrase {
  String pronounObject;

  PrepositionalPhraseWithPronounObject({
    required super.preposition,
    required this.pronounObject,
  });

  @override
  // TODO: implement adverbType, it can be: place, time
  AdverbType get adverbType => throw UnimplementedError();

  @override
  String toString() => '$preposition $pronounObject';
}
