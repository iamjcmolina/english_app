import 'package:flutter/material.dart';

import '../../model/clause/adjective_clause.dart';

class RelativeClauseBuilder extends StatelessWidget {
  const RelativeClauseBuilder({super.key, required this.clause, required this.setClause});
  final AdjectiveClause? clause;
  final Function(AdjectiveClause) setClause;

  @override
  Widget build(BuildContext context) {
    return const Text('Adjective/relative clause');
  }
}
