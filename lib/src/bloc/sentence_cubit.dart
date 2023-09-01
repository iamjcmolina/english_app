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
      : super(Sentence(
            independentClause: IndependentClause(
                options: IndependentClauseOptions(
          type: ClauseType.affirmative,
          tense: Tense.simplePresent,
        ))));

  void setIndependentClause(IndependentClause independentClause) {
    emit(state.copyWith(independentClause: independentClause));
  }

  void setOptions(IndependentClauseOptions options) {
    setIndependentClause(state.independentClause.copyWith(options: options));
  }

  void toggleModalVerb() {
    bool setOffEmphasis =
        state.independentClause.options.enableAffirmativeEmphasis &&
            !state.independentClause.options.enableModalVerb;
    setOptions(state.independentClause.options.copyWith(
        enableModalVerb: !state.independentClause.options.enableModalVerb,
        enableAffirmativeEmphasis: setOffEmphasis
            ? false
            : state.independentClause.options.enableAffirmativeEmphasis));
  }

  void toggleContractions() {
    setOptions(state.independentClause.options.copyWith(
        enableContractions:
            !state.independentClause.options.enableContractions));
  }

  void toggleAlternativeContractionToBeVerb() {
    setOptions(state.independentClause.options.copyWith(
        enableSecondContractionToBe:
            !state.independentClause.options.enableSecondContractionToBe));
  }

  void toggleAffirmativeEmphasis() {
    bool disableModalVerbEmphasis =
        state.independentClause.options.enableModalVerb &&
            !state.independentClause.options.enableAffirmativeEmphasis;
    setOptions(state.independentClause.options.copyWith(
        enableAffirmativeEmphasis:
            !state.independentClause.options.enableAffirmativeEmphasis,
        enableModalVerb: disableModalVerbEmphasis
            ? false
            : state.independentClause.options.enableModalVerb));
  }

  void setClauseType(ClauseType type) {
    setOptions(state.independentClause.options.copyWith(type: type));
  }

  void setTense(Tense tense) {
    setOptions(state.independentClause.options.copyWith(tense: tense));
  }

  void setSubjectType(SubjectType subjectType) {
    setIndependentClause(
        state.independentClause.copyWith(subjectType: subjectType));
  }

  void setSubject(Subject? subject) {
    setIndependentClause(
        state.independentClause.copyWith(subject: Nullable(subject)));
  }

  void setVerb(Verb? verb) {
    setIndependentClause(
        state.independentClause.copyWith(verb: Nullable(verb)));
  }
}
