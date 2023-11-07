import 'clause/independent_clause.dart';

class Sentence {
  final IndependentClause independentClause;

  const Sentence({required this.independentClause});

  Sentence copyWith({
    IndependentClause? independentClause,
  }) =>
      Sentence(
        independentClause: independentClause ?? this.independentClause,
      );
}
