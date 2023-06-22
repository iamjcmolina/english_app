import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/clause/clause_type.dart';
import '../model/clause/independent_clause.dart';
import '../model/common/nullable.dart';
import '../model/noun/subject.dart';
import '../model/noun/subject_type.dart';
import '../model/sentence.dart';
import '../model/tense.dart';
import '../model/verb/empty_verb.dart';
import '../model/verb/verb.dart';

class SentenceCubit extends Cubit<Sentence> {
  SentenceCubit()
      : super(Sentence(independentClause: IndependentClause(
          type: ClauseType.affirmative,
          tense: Tense.simplePresent,
        )));

  void setIndependentClause(IndependentClause independentClause) {
    emit(state.copyWith(independentClause: independentClause));
  }

  void toggleContractions() {
    setIndependentClause(state.independentClause.copyWith(enableContractions: !state.independentClause.enableContractions));
  }

  void toggleAlternativeContractionToBeVerb() {
    setIndependentClause(state.independentClause.copyWith(enableSecondContractionToBe: !state.independentClause.enableSecondContractionToBe));
  }

  void toggleAffirmativeEmphasis() {
    setIndependentClause(state.independentClause.copyWith(enableAffirmativeEmphasis: !state.independentClause.enableAffirmativeEmphasis));
  }

  void setClauseType(ClauseType type) {
    setIndependentClause(state.independentClause.copyWith(type: type));
  }

  void setTense(Tense tense) {
    setIndependentClause(state.independentClause.copyWith(tense: tense));
  }

  void setSubjectType(SubjectType subjectType) {
    setIndependentClause(state.independentClause.copyWith(subjectType: subjectType));
  }

  void setSubject(Subject? subject) {
    setIndependentClause(state.independentClause.copyWith(subject: Nullable(subject)));
  }

  void setVerb(Verb? verb) {
    setIndependentClause(state.independentClause.copyWith(verb: Nullable(verb)));
  }
}
