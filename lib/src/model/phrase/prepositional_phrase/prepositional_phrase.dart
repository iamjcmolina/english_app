import '../../adverb/adverb.dart';
import '../../clause/noun_clause.dart';
import '../../noun/noun.dart';
import '../../nullable.dart';
import '../../preposition/preposition.dart';
import '../../verb/verb.dart';
import '../../adjective/adjective.dart';
import '../gerund_phrase/gerund_phrase.dart';
import '../infinitive_phrase/infinitive_phrase.dart';
import '../participle_phrase/perfect_participle_phrase.dart';

abstract class PrepositionalPhrase implements Adverb, Adjective {
  Preposition preposition;

  PrepositionalPhrase({required this.preposition});
}
