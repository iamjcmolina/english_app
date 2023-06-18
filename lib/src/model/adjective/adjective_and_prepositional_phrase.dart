import '../phrase/prepositional_phrase/prepositional_phrase.dart';
import 'adjective_and_adjective_complement.dart';

class AdjectiveAndPrepositionalPhrase extends AdjectiveAndAdjectiveComplement {
  PrepositionalPhrase prepositionalPhrase;

  AdjectiveAndPrepositionalPhrase({required super.adjective, required this.prepositionalPhrase});

  @override
  String toString() => '$adjective $prepositionalPhrase';
}
