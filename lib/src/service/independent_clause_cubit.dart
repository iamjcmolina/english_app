import 'package:bloc/bloc.dart';

import '../model/sentence/clause/independent_clause.dart';

class IndependentClauseCubit extends Cubit<IndependentClause> {
  IndependentClauseCubit() : super(const IndependentClause());
}
