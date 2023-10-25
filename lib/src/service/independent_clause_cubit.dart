import 'package:bloc/bloc.dart';

import '../model/sentence/clause/independent_clause.dart';
import 'independent_clause_service.dart';

class IndependentClauseCubit extends Cubit<IndependentClause> {
  IndependentClauseService clauseService;

  IndependentClauseCubit(this.clauseService) : super(const IndependentClause());
}
