import 'clause/independent_clause.dart';

class Sentence {
  IndependentClause independentClause;

  Sentence({required this.independentClause});

  Sentence copyWith({
    IndependentClause? independentClause,
  }) => Sentence(
    independentClause: independentClause ?? this.independentClause,
  );

  @override
  String toString() => '$independentClause';
}
