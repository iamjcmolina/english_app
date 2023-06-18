import '../phrase/infinitive_phrase/infinitive_phrase.dart';
import 'adjective_and_adjective_complement.dart';

class AdjectiveAndInfinitivePhrase extends AdjectiveAndAdjectiveComplement {
  final InfinitivePhrase infinitivePhrase;

  AdjectiveAndInfinitivePhrase({required super.adjective, required this.infinitivePhrase});

  @override
  String toString() => '$adjective $infinitivePhrase';
}
