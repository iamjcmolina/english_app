import '../nullable.dart';
import 'indirect_object_type.dart';
import 'noun_phrase.dart';

class IndirectObject {
  IndirectObjectType type;
  String? pronoun;
  String? ownName;
  NounPhrase? nounPhrase;

  IndirectObject({
    required this.type,
    this.pronoun,
    this.ownName,
    this.nounPhrase,
  });

  IndirectObject copyWith({
    IndirectObjectType? type,
    Nullable<String>? pronoun,
    Nullable<String>? ownName,
    Nullable<NounPhrase>? nounPhrase,
  }) => IndirectObject(
    type: type ?? this.type,
    pronoun: pronoun == null ? this.pronoun : pronoun.value,
    ownName: ownName == null ? this.ownName : ownName.value,
    nounPhrase: nounPhrase == null ? this.nounPhrase : nounPhrase.value,
  );

  @override
  String toString() {
    String string = '';
    if(type == IndirectObjectType.pronoun) {
      string += pronoun ?? '<Pronoun>';
    } else if(type == IndirectObjectType.ownName) {
      string += ownName ?? '<Own name>';
    } else if(type == IndirectObjectType.nounPhrase) {
      string += nounPhrase == null ? '<Noun phrase>' : '$nounPhrase';
    }
    return string;
  }
}
