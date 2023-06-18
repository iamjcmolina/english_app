import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/clause/clause_type.dart';
import '../model/clause/independent_clause.dart';
import '../model/noun/pronoun.dart';
import '../model/sentence.dart';
import '../model/tense.dart';
import '../model/verb/empty_verb.dart';

class SentenceCubit extends Cubit<Sentence> {
  SentenceCubit()
      : super(Sentence(independentClause: IndependentClause(
          type: ClauseType.affirmative,
          tense: Tense.simplePresent,
          subject: Pronoun('I'),
          verb: EmptyVerb(),
        )));

  void setIndependentClause(IndependentClause independentClause) {
    emit(state.copyWith(independentClause: independentClause));
  }
}
