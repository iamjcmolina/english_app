import '../clause/adjective_clause.dart';
import '../clause/noun_clause.dart';
import '../nullable.dart';
import '../phrase/gerund_phrase/gerund_phrase.dart';
import '../phrase/infinitive_phrase/infinitive_phrase.dart';
import 'direct_object_type.dart';
import 'noun_phrase.dart';

class DirectObject {
  DirectObjectType type;
  String? pronoun;
  String? ownName;
  NounPhrase? nounPhrase;
  String? gerund;
  GerundPhrase? gerundPhrase;
  String? infinitive;
  InfinitivePhrase? infinitivePhrase;
  AdjectiveClause? adjectiveClause;
  NounClause? nounClause;

  DirectObject({
    required this.type,
    this.pronoun,
    this.ownName,
    this.nounPhrase,
    this.gerundPhrase,
    this.infinitivePhrase,
    this.adjectiveClause,
  });

  DirectObject copyWith({
    DirectObjectType? type,
    Nullable<String>? pronoun,
    Nullable<String>? ownName,
    Nullable<NounPhrase>? nounPhrase,
    Nullable<GerundPhrase>? gerundPhrase,
    Nullable<InfinitivePhrase>? infinitivePhrase,
    Nullable<AdjectiveClause>? adjectiveClause,
  }) => DirectObject(
    type: type ?? this.type,
    pronoun: pronoun == null ? this.pronoun : pronoun.value,
    ownName: ownName == null ? this.ownName : ownName.value,
    nounPhrase: nounPhrase == null ? this.nounPhrase : nounPhrase.value,
    gerundPhrase: gerundPhrase == null ? this.gerundPhrase : gerundPhrase.value,
    infinitivePhrase: infinitivePhrase == null ? this.infinitivePhrase : infinitivePhrase.value,
    adjectiveClause: adjectiveClause == null ? this.adjectiveClause : adjectiveClause.value,
  );

  @override
  String toString() {
    String string = '';
    if(type == DirectObjectType.pronoun) {
      string += pronoun ?? '<Pronoun>';
    } else if(type == DirectObjectType.ownName) {
      string += ownName ?? '<Own name>';
    } else if(type == DirectObjectType.nounPhrase) {
      string += nounPhrase == null ? '<Noun phrase>' : '$nounPhrase';
    } else if(type == DirectObjectType.gerundPhrase) {
      string += gerundPhrase == null? '<Gerund phrase>' : '$gerundPhrase';
    } else if(type == DirectObjectType.infinitivePhrase) {
      string += infinitivePhrase == null? '<Infinitive phrase>' : '$infinitivePhrase';
    } else if(type == DirectObjectType.adjectiveClause) {
      string += adjectiveClause == null? '<Adjective clause>' : '$adjectiveClause';
    }
    return string;
  }
}
