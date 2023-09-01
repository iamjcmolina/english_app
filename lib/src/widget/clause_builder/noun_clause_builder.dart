import 'package:flutter/material.dart';

import '../../model/clause/noun_clause.dart';

class NounClauseBuilder extends StatelessWidget {
  const NounClauseBuilder({super.key, required this.clause, required this.setClause});
  final NounClause? clause;
  final Function(NounClause) setClause;

  @override
  Widget build(BuildContext context) {
    return const Text('Noun clause builder in progress...');
  }
}
