import '../noun/value/noun_type.dart';
import 'value/clause_type.dart';
import 'value/tense.dart';

class IndependentClauseSettings {
  final bool modalVerb;
  final bool affirmativeEmphasis;
  final bool contraction;
  final bool negativeContraction;
  final ClauseType clauseType;
  final Tense tense;

  const IndependentClauseSettings({
    this.modalVerb = false,
    this.affirmativeEmphasis = false,
    this.contraction = true,
    this.negativeContraction = false,
    this.clauseType = ClauseType.affirmative,
    this.tense = Tense.simplePresent,
  });

  IndependentClauseSettings copyWith({
    bool? modalVerb,
    bool? affirmativeEmphasis,
    bool? contraction,
    bool? negativeContraction,
    ClauseType? clauseType,
    Tense? tense,
    NounType? subjectType,
  }) => IndependentClauseSettings(
    modalVerb: modalVerb ?? this.modalVerb,
    affirmativeEmphasis: affirmativeEmphasis ?? this.affirmativeEmphasis,
    contraction: contraction ?? this.contraction,
    negativeContraction: negativeContraction ?? this.negativeContraction,
    clauseType: clauseType ?? this.clauseType,
    tense: tense ?? this.tense,
  );

  bool get isAffirmative => clauseType == ClauseType.affirmative;
  bool get isNegative => clauseType == ClauseType.negative;
  bool get isInterrogative => clauseType == ClauseType.interrogative;
  bool get isSimplePresent => tense == Tense.simplePresent;
  bool get isSimplePast => tense == Tense.simplePast;
  bool get isSimpleFuture => tense == Tense.simpleFuture;
  bool get isSimplePresentPerfect => tense == Tense.simplePresentPerfect;
  bool get isSimplePastPerfect => tense == Tense.simplePastPerfect;
  bool get isSimpleFuturePerfect => tense == Tense.simpleFuturePerfect;
  bool get isContinuousPresent => tense == Tense.continuousPresent;
  bool get isContinuousPast => tense == Tense.continuousPast;
  bool get isContinuousFuture => tense == Tense.continuousFuture;
  bool get isContinuousPresentPerfect => tense == Tense.continuousPresentPerfect;
  bool get isContinuousPastPerfect => tense == Tense.continuousPastPerfect;
  bool get isContinuousFuturePerfect => tense == Tense.continuousFuturePerfect;
}
