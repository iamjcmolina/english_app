import 'package:bloc/bloc.dart';

import '../model/nullable.dart';
import '../model/sentence/clause/independent_clause.dart';
import '../model/sentence/clause/independent_clause_options.dart';
import '../model/sentence/clause/value/clause_type.dart';
import '../model/sentence/clause/value/tense.dart';
import '../model/sentence/noun/subject.dart';
import '../model/sentence/noun/value/subject_type.dart';
import '../model/sentence/sentence.dart';
import '../model/sentence/verb/any_verb.dart';

class SentenceCubit extends Cubit<Sentence> {
  SentenceCubit() : super(
      Sentence(
          independentClause: IndependentClause(
              options: const IndependentClauseOptions(),
          )
      )
  );

  void setIndependentClause(IndependentClause independentClause) {
    emit(state.copyWith(independentClause: independentClause));
  }

  void setSubject(Subject? subject) {
    setIndependentClause(
        state.independentClause.copyWith(subject: Nullable(subject)));
  }

  void setVerb(AnyVerb? verb) {
    setIndependentClause(
        state.independentClause.copyWith(verb: Nullable(verb)));
  }

  void setOptions(IndependentClauseOptions options) {
    setIndependentClause(state.independentClause.copyWith(options: options));
  }

  void setClauseType(ClauseType clauseType) {
    setOptions(state.independentClause.options.copyWith(clauseType: clauseType));
  }

  void setTense(Tense tense) {
    setOptions(state.independentClause.options.copyWith(tense: tense));
  }

  void setSubjectType(SubjectType subjectType) {
    setOptions(state.independentClause.options.copyWith(subjectType: subjectType));
  }

  void toggleModalVerb() {
    bool turnOffEmphasis =
        state.independentClause.options.affirmativeEmphasis &&
            !state.independentClause.options.modalVerb;
    setOptions(state.independentClause.options.copyWith(
        modalVerb: !state.independentClause.options.modalVerb,
        affirmativeEmphasis: turnOffEmphasis
            ? false
            : state.independentClause.options.affirmativeEmphasis));
  }

  void toggleCollapseFirstAuxiliaryVerb() {
    setOptions(state.independentClause.options.copyWith(
        collapseFirstAuxiliaryVerb:
        !state.independentClause.options.collapseFirstAuxiliaryVerb));
  }

  void toggleCollapseNegativeFirstAuxiliaryVerb() {
    setOptions(state.independentClause.options.copyWith(
        collapseNegativeFirstAuxiliaryVerb:
        !state.independentClause.options.collapseNegativeFirstAuxiliaryVerb));
  }

  void toggleAffirmativeEmphasis() {
    bool disableModalVerbEmphasis =
        state.independentClause.options.modalVerb &&
            !state.independentClause.options.affirmativeEmphasis;
    setOptions(state.independentClause.options.copyWith(
        affirmativeEmphasis:
        !state.independentClause.options.affirmativeEmphasis,
        modalVerb: disableModalVerbEmphasis
            ? false
            : state.independentClause.options.modalVerb));
  }
}