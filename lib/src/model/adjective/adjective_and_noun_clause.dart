import '../clause/noun_clause.dart';
import 'adjective_and_adjective_complement.dart';

class AdjectiveAndNounClause extends AdjectiveAndAdjectiveComplement {
  final NounClause nounClause;

  AdjectiveAndNounClause({required super.adjective, required this.nounClause});

  @override
  String toString() => '$adjective $nounClause';
}
