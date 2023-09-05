import '../noun/value/subject_type.dart';
import 'value/clause_type.dart';
import 'value/tense.dart';

class IndependentClauseOptions {
  final bool affirmativeEmphasis;
  final bool collapseFirstAuxiliaryVerb;
  final bool collapseNegativeFirstAuxiliaryVerb;
  final bool modalVerb;
  final ClauseType clauseType;
  final Tense tense;
  final SubjectType subjectType;

  const IndependentClauseOptions({
    this.affirmativeEmphasis = false,
    this.collapseFirstAuxiliaryVerb = true,
    this.collapseNegativeFirstAuxiliaryVerb = false,
    this.modalVerb = false,
    this.clauseType = ClauseType.affirmative,
    this.tense = Tense.simplePresent,
    this.subjectType = SubjectType.pronoun,
  });

  IndependentClauseOptions copyWith({
    bool? affirmativeEmphasis,
    bool? collapseFirstAuxiliaryVerb,
    bool? collapseNegativeFirstAuxiliaryVerb,
    bool? modalVerb,
    ClauseType? clauseType,
    Tense? tense,
    SubjectType? subjectType,
  }) => IndependentClauseOptions(
    affirmativeEmphasis: affirmativeEmphasis ?? this.affirmativeEmphasis,
    collapseFirstAuxiliaryVerb: collapseFirstAuxiliaryVerb ?? this.collapseFirstAuxiliaryVerb,
    collapseNegativeFirstAuxiliaryVerb: collapseNegativeFirstAuxiliaryVerb ?? this.collapseNegativeFirstAuxiliaryVerb,
    modalVerb: modalVerb ?? this.modalVerb,
    clauseType: clauseType ?? this.clauseType,
    tense: tense ?? this.tense,
    subjectType: subjectType ?? this.subjectType,
  );
}
