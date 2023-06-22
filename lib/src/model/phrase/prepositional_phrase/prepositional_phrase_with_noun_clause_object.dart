import '../../adverb/adverb_type.dart';
import '../../clause/noun_clause.dart';
import 'prepositional_phrase.dart';

class PrepositionalPhraseWithNounClauseObject extends PrepositionalPhrase {
  NounClause nounClause;

  PrepositionalPhraseWithNounClauseObject({
    required super.preposition,
    required this.nounClause,
  });

  @override
  // TODO: implement adverbType, it can be: place, time
  AdverbType get adverbType => throw UnimplementedError();

  @override
  String toString() => '$preposition $nounClause';
}
