import '../../adverb/adverb_type.dart';
import 'prepositional_phrase.dart';

class PrepositionalPhraseWithOwnNameObject extends PrepositionalPhrase {
  String ownNameObject;

  PrepositionalPhraseWithOwnNameObject({
    required super.preposition,
    required this.ownNameObject,
  });

  @override
  // TODO: implement adverbType, it can be: place, time
  AdverbType get adverbType => throw UnimplementedError();

  @override
  String toString() => '$preposition $ownNameObject';
}
