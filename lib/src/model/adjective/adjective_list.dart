import 'adjective.dart';
import 'adjective_word.dart';

class AdjectiveList implements Adjective {
  final List<AdjectiveWord> adjectives;

  AdjectiveList({this.adjectives = const []});

  @override
  String toString() => adjectives.fold('', (previousValue, adjectiveWord) => ' ${adjectiveWord.adjective}');
}
