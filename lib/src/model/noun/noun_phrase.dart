import '../adjective/adjective.dart';
import '../nullable.dart';
import 'noun.dart';

class NounPhrase {
  NounPhrase({
    this.determiner,
    this.adjective,
    this.noun,
  });
  final String? determiner;
  final Adjective? adjective;
  final Noun? noun;

  NounPhrase copyWith({
    Nullable<String>? determiner,
    Nullable<Adjective>? adjective,
    Nullable<Noun>? noun,
  }) => NounPhrase(
    determiner: determiner == null? this.determiner : determiner.value,
    adjective: adjective == null? this.adjective : adjective.value,
    noun: noun == null? this.noun : noun.value,
  );

  @override
  String toString() {
    String string = '';
    bool countable = noun?.isCountable ?? true;
    bool singular = noun?.isSingular ?? true;
    String determinerPlaceholder = countable && singular? ' <Determiner>' : '';
    string += determiner == null? determinerPlaceholder : ' $determiner';
    if(adjective != null) {
      string += ' $adjective';
    }
    string += noun == null? ' <Noun>' : ' $noun';
    return string;
  }
}
