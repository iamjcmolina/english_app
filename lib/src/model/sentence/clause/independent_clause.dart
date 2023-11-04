import '../../label.dart';
import '../../nullable.dart';
import '../adverb/any_adverb.dart';
import '../noun/any_noun.dart';
import '../noun/doer.dart';
import '../noun/subject_complement.dart';
import '../verb/any_verb.dart';
import '../verb/auxiliary_verb_type.dart';
import '../verb/auxiliary_verbs.dart';
import '../verb/be.dart';
import '../verb/contraction_type.dart';
import '../verb/have.dart';
import '../verb/modal_verb.dart';
import '../verb/verb_tense.dart';
import 'clause_type.dart';
import 'tense.dart';

class IndependentClause {
  final AuxiliaryVerbType? auxiliaryVerbType;
  final ContractionType? contractionType;
  final ClauseType clauseType;
  final Tense tense;
  final AnyAdverb? frontAdverb;
  final AnyNoun? subject;
  final ModalVerb? modalVerb;
  final AnyAdverb? midAdverb;
  final AnyVerb? verb;
  final AnyNoun? indirectObject;
  final AnyNoun? directObject;
  final SubjectComplement? subjectComplement;
  final AnyAdverb? endAdverb;

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
  bool get isContinuousPresentPerfect =>
      tense == Tense.continuousPresentPerfect;
  bool get isContinuousPastPerfect => tense == Tense.continuousPastPerfect;
  bool get isContinuousFuturePerfect => tense == Tense.continuousFuturePerfect;

  bool get hasSingularFirstPersonSubject =>
      subject?.isSingularFirstPerson ?? true;
  bool get hasSingularThirdPersonSubject =>
      subject?.isSingularThirdPerson ?? false;
  bool get hasPluralSubject => subject?.isPlural ?? false;
  Doer get subjectAsDoer => subject?.asDoer ?? Doer.I;
  Doer get subjectAsDoerEs => subject?.asDoerEs ?? Doer.I;

  bool get isWouldModalVerb => modalVerb?.isWould ?? false;

  bool get hasTransitiveVerb => verb?.isTransitive ?? false;
  bool get hasDitransitiveVerb => verb?.isDitransitive ?? false;
  bool get hasLinkingVerb => verb?.isLinkingVerb ?? false;

  String get modalVerbPlaceholder =>
      isNegative ? Label.negativeModalVerb : Label.modalVerb;

  String get verbPlaceholder => switch (verbTense) {
        VerbTense.present => Label.presentVerb,
        VerbTense.past => Label.pastVerb,
        VerbTense.progressive => Label.progressiveVerb,
        VerbTense.pastParticiple => Label.pastParticipleVerb,
        _ => Label.infinitiveVerb,
      };

  bool get isVerbContractionActive {
    final hasContractedModalVerb = modalVerb?.hasVerbContraction ?? false;
    return switch (tense) {
      Tense.simplePresent || Tense.continuousPresent => !isInterrogative &&
          isVerbContractionEnabled &&
          (isModalVerbEnabled && hasContractedModalVerb || isBeAuxiliary),
      Tense.simplePast || Tense.continuousPast => false,
      _ => !isInterrogative && isVerbContractionEnabled,
    };
  }

  bool get isBeAuxiliary => switch (tense) {
        Tense.simplePresent => !isModalVerbEnabled && verb is Be,
        Tense.simplePast => verb is Be,
        _ => false,
      };

  String get firstAuxiliaryVerbDescription => [
        if ((isSimplePresent || isContinuousPresent) && isModalVerbEnabled)
          'Modal Verb',
        if ((isSimplePresent || isSimplePast) && isAffirmativeEmphasisEnabled)
          'Affirmative Emphasis',
        if (isVerbContractionEnabled) 'Verb Contraction',
        if (isNegativeContractionEnabled) 'Negative Contraction',
      ].join(', ');

  AuxiliaryVerbs get auxiliaryVerbs => switch (tense) {
        Tense.simplePresent => _simplePresent,
        Tense.simplePast => _simplePast,
        Tense.simpleFuture => _simpleFuture,
        Tense.simplePresentPerfect => _simplePresentPerfect,
        Tense.simplePastPerfect => _simplePastPerfect,
        Tense.simpleFuturePerfect => _simpleFuturePerfect,
        Tense.continuousPresent => _continuousPresent,
        Tense.continuousPast => _continuousPast,
        Tense.continuousFuture => _continuousFuture,
        Tense.continuousPresentPerfect => _continuousPresentPerfect,
        Tense.continuousPastPerfect => _continuousPastPerfect,
        Tense.continuousFuturePerfect => _continuousFuturePerfect,
      };

  AuxiliaryVerbs get _simplePresent => AuxiliaryVerbs(
      first: isNegative
          ? isModalVerbEnabled
              ? conjugateModal()
              : verb is Be
                  ? Be.ser.simplePresent(this)
                  : isNegativeContractionEnabled
                      ? hasSingularThirdPersonSubject
                          ? "doesn't"
                          : "don't"
                      : hasSingularThirdPersonSubject
                          ? 'does not'
                          : 'do not'
          : isModalVerbEnabled
              ? conjugateModal()
              : verb is Be
                  ? Be.ser.simplePresent(this)
                  : isInterrogative || isAffirmativeEmphasisEnabled
                      ? hasSingularThirdPersonSubject
                          ? 'does'
                          : 'do'
                      : null,
      firstEs: isModalVerbEnabled
          ? conjugateModalEs()
          : verb is Be
              ? Be.ser.simplePresentEs(this)
              : isNegative
                  ? 'no'
                  : '');

  AuxiliaryVerbs get _simplePast => AuxiliaryVerbs(
        first: isNegative
            ? verb is Be
                ? Be.ser.simplePast(this)
                : isNegativeContractionEnabled
                    ? "didn't"
                    : 'did not'
            : verb is Be
                ? Be.ser.simplePast(this)
                : isInterrogative || isAffirmativeEmphasisEnabled
                    ? 'did'
                    : null,
        firstEs: verb is Be
            ? Be.ser.simplePastEs(this)
            : isNegative
                ? 'no'
                : '',
      );

  AuxiliaryVerbs get _simpleFuture => AuxiliaryVerbs(
        first: isNegative
            ? isVerbContractionEnabled
                ? "'ll not"
                : (isNegativeContractionEnabled ? "won't" : 'will not')
            : (isAffirmative && isVerbContractionEnabled ? "'ll" : 'will'),
        firstEs: isNegative ? "no" : '',
      );

  AuxiliaryVerbs get _simplePresentPerfect => AuxiliaryVerbs(
        first: Have.haber.simplePresent(this),
        firstEs: Have.haber.simplePresentEs(this),
      );

  AuxiliaryVerbs get _simplePastPerfect => AuxiliaryVerbs(
        first: Have.haber.simplePast(this),
        firstEs: Have.haber.simplePastEs(this),
      );

  AuxiliaryVerbs get _simpleFuturePerfect => AuxiliaryVerbs(
        first: isNegative
            ? isVerbContractionEnabled
                ? "'ll not"
                : (isNegativeContractionEnabled ? "won't" : 'will not')
            : (isAffirmative && isVerbContractionEnabled ? "'ll" : 'will'),
        second: Have.haber.infinitive,
        firstEs: isNegative ? 'no' : '',
        secondEs: Have.haber.futureEs(this),
      );

  AuxiliaryVerbs get _continuousPresent => AuxiliaryVerbs(
        first: isModalVerbEnabled
            ? conjugateModal()
            : Be.estar.simplePresent(this),
        second: isModalVerbEnabled ? Be.estar.infinitive : null,
        firstEs: isModalVerbEnabled
            ? conjugateModalEs()
            : Be.estar.simplePresentEs(this),
        secondEs: isModalVerbEnabled ? Be.estar.infinitiveEs : null,
      );

  AuxiliaryVerbs get _continuousPast => AuxiliaryVerbs(
        first: Be.estar.simplePast(this),
        firstEs: Be.estar.simplePastEs(this),
      );

  AuxiliaryVerbs get _continuousFuture => AuxiliaryVerbs(
        first: isNegative
            ? isVerbContractionEnabled
                ? "'ll not"
                : (isNegativeContractionEnabled ? "won't" : 'will not')
            : (isAffirmative && isVerbContractionEnabled ? "'ll" : 'will'),
        second: Be.estar.infinitive,
        firstEs: isNegative ? 'no' : '',
        secondEs: Be.estar.futureEs(this),
      );

  AuxiliaryVerbs get _continuousPresentPerfect => AuxiliaryVerbs(
        first: Have.haber.simplePresent(this),
        second: Be.estar.pastParticiple,
        firstEs: Have.haber.simplePresentEs(this),
        secondEs: Be.estar.pastParticipleEs,
      );

  AuxiliaryVerbs get _continuousPastPerfect => AuxiliaryVerbs(
        first: Have.haber.simplePast(this),
        second: Be.estar.pastParticiple,
        firstEs: Have.haber.simplePastEs(this),
        secondEs: Be.estar.pastParticipleEs,
      );

  AuxiliaryVerbs get _continuousFuturePerfect => AuxiliaryVerbs(
        first: isNegative
            ? isVerbContractionEnabled
                ? "'ll not"
                : (isNegativeContractionEnabled ? "won't" : 'will not')
            : (isAffirmative && isVerbContractionEnabled ? "'ll" : 'will'),
        second: Have.haber.infinitive,
        third: Be.estar.pastParticiple,
        firstEs: isNegative ? 'no' : '',
        secondEs: Have.haber.futureEs(this),
        thirdEs: Be.estar.pastParticipleEs,
      );

  VerbTense get verbTense => isSimplePresent
      ? VerbTense.present
      : isSimplePast
          ? VerbTense.past
          : isSimpleFuture
              ? VerbTense.infinitive
              : isSimplePresentPerfect ||
                      isSimplePastPerfect ||
                      isSimpleFuturePerfect
                  ? VerbTense.pastParticiple
                  : VerbTense.progressive;

  VerbTense get verbTenseEs => isSimplePresent
      ? isModalVerbEnabled
          ? (isWouldModalVerb ? VerbTense.conditional : VerbTense.infinitive)
          : VerbTense.present
      : isSimplePast
          ? VerbTense.past
          : isSimpleFuture
              ? VerbTense.future
              : isSimplePresentPerfect ||
                      isSimplePastPerfect ||
                      isSimpleFuturePerfect
                  ? VerbTense.pastParticiple
                  : VerbTense.progressive;

  String get modalVerbPlaceholderEs =>
      isNegative ? Label.negativeModalVerbEs : Label.modalVerbEs;

  String get verbPlaceholderEs => switch (verbTense) {
        VerbTense.infinitive => Label.infinitiveVerbEs,
        VerbTense.present => Label.presentVerbEs,
        VerbTense.past => Label.pastVerbEs,
        VerbTense.future => Label.futureVerbEs,
        VerbTense.progressive => Label.progressiveVerbEs,
        VerbTense.pastParticiple => Label.pastParticipleVerbEs,
        VerbTense.conditional => Label.conditionalVerbEs,
      };

  bool get isValid => false;

  bool get isModalVerbEnabled => auxiliaryVerbType == AuxiliaryVerbType.modal;
  bool get isAffirmativeEmphasisEnabled =>
      auxiliaryVerbType == AuxiliaryVerbType.emphasis;
  bool get isVerbContractionEnabled => contractionType == ContractionType.verb;
  bool get isNegativeContractionEnabled =>
      contractionType == ContractionType.negative;

  const IndependentClause({
    this.auxiliaryVerbType,
    this.contractionType,
    this.clauseType = ClauseType.affirmative,
    this.tense = Tense.simplePresent,
    this.frontAdverb,
    this.subject,
    this.modalVerb,
    this.midAdverb,
    this.verb,
    this.indirectObject,
    this.directObject,
    this.subjectComplement,
    this.endAdverb,
  });

  IndependentClause copyWith({
    Nullable<AuxiliaryVerbType>? auxiliaryVerbType,
    Nullable<ContractionType>? contractionType,
    ClauseType? clauseType,
    Tense? tense,
    Nullable<AnyAdverb>? frontAdverb,
    Nullable<AnyNoun>? subject,
    Nullable<ModalVerb>? modalVerb,
    Nullable<AnyAdverb>? midAdverb,
    Nullable<AnyVerb>? verb,
    Nullable<AnyNoun>? indirectObject,
    Nullable<AnyNoun>? directObject,
    Nullable<SubjectComplement>? subjectComplement,
    Nullable<AnyAdverb>? endAdverb,
  }) =>
      IndependentClause(
        auxiliaryVerbType: auxiliaryVerbType == null
            ? this.auxiliaryVerbType
            : auxiliaryVerbType.value,
        contractionType: contractionType == null
            ? this.contractionType
            : contractionType.value,
        clauseType: clauseType ?? this.clauseType,
        tense: tense ?? this.tense,
        frontAdverb: frontAdverb == null ? this.frontAdverb : frontAdverb.value,
        subject: subject == null ? this.subject : subject.value,
        modalVerb: modalVerb == null ? this.modalVerb : modalVerb.value,
        midAdverb: midAdverb == null ? this.midAdverb : midAdverb.value,
        verb: verb == null ? this.verb : verb.value,
        indirectObject:
            indirectObject == null ? this.indirectObject : indirectObject.value,
        directObject:
            directObject == null ? this.directObject : directObject.value,
        subjectComplement: subjectComplement == null
            ? this.subjectComplement
            : subjectComplement.value,
        endAdverb: endAdverb == null ? this.endAdverb : endAdverb.value,
      );

  String? conjugateVerb([AnyVerb? other]) {
    final verb = other ?? this.verb;
    if (verb == null) {
      return null;
    }
    return switch (verbTense) {
      VerbTense.present => verb.simplePresent(this),
      VerbTense.past => verb.simplePast(this),
      VerbTense.progressive => verb.progressive,
      VerbTense.pastParticiple => verb.pastParticiple,
      _ => verb.infinitive,
    };
  }

  String? conjugateVerbEs([AnyVerb? other]) {
    final verb = other ?? this.verb;
    if (verb == null) {
      return null;
    }
    return switch (verbTenseEs) {
      VerbTense.present => verb.simplePresentEs(this),
      VerbTense.past => verb.simplePastEs(this),
      VerbTense.future => verb.futureEs(this),
      VerbTense.conditional => verb.conditionalEs(this),
      VerbTense.progressive => verb.progressiveEs,
      VerbTense.pastParticiple => verb.pastParticipleEs,
      VerbTense.infinitive => verb.infinitiveEs
    };
  }

  String? conjugateModal([ModalVerb? other]) {
    final modal = other ?? modalVerb;
    return modal == null
        ? null
        : isNegative
            ? isVerbContractionEnabled
                ? modal.negativeWithVerbContraction
                : isNegativeContractionEnabled
                    ? modal.negativeContraction
                    : modal.negative
            : isAffirmative && isVerbContractionEnabled
                ? modal.verbContraction
                : modal.verb;
  }

  String? conjugateModalEs([ModalVerb? other]) {
    final modal = other ?? modalVerb;
    if (modal == null) {
      return null;
    }
    final affirmative = switch (subjectAsDoerEs) {
      Doer.I => modal.affirmativeIEs,
      Doer.you => modal.affirmativeYouEs,
      Doer.we => modal.affirmativeWeEs,
      Doer.they => modal.affirmativeTheyEs,
      Doer.he || Doer.she || Doer.it => modal.affirmativeHeEs,
    };
    return isNegative ? 'no $affirmative' : affirmative;
  }
}
