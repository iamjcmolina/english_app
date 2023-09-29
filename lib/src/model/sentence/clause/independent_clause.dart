import '../../nullable.dart';
import '../adverb/any_adverb.dart';
import '../adverb/undefined_adverb.dart';
import '../noun/any_noun.dart';
import '../noun/direct_object.dart';
import '../noun/indirect_object.dart';
import '../noun/subject_complement.dart';
import '../noun/undefined_direct_object.dart';
import '../noun/undefined_indirect_object.dart';
import '../noun/undefined_subject.dart';
import '../noun/undefined_subject_complement.dart';
import '../verb/any_verb.dart';
import '../verb/be.dart';
import '../verb/modal_verb.dart';
import '../verb/undefined_modal_verb.dart';
import '../verb/undefined_verb.dart';
import 'independent_clause_settings.dart';
import 'value/tense.dart';

class IndependentClause {
  IndependentClauseSettings settings;
  AnyAdverb? frontAdverb;
  AnyNoun? subject;
  ModalVerb? modalVerb;
  AnyAdverb? midAdverb;
  AnyVerb? verb;
  IndirectObject? indirectObject;
  DirectObject? directObject;
  SubjectComplement? subjectComplement;
  AnyAdverb? endAdverb;

  IndependentClause({
    this.settings = const IndependentClauseSettings(),
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
    IndependentClauseSettings? settings,
    Nullable<AnyAdverb>? frontAdverb,
    Nullable<AnyNoun>? subject,
    Nullable<ModalVerb>? modalVerb,
    Nullable<AnyAdverb>? midAdverb,
    Nullable<AnyVerb>? verb,
    Nullable<IndirectObject>? indirectObject,
    Nullable<DirectObject>? directObject,
    Nullable<SubjectComplement>? subjectComplement,
    Nullable<AnyAdverb>? endAdverb,
  }) => IndependentClause(
    settings: settings ?? this.settings,
    frontAdverb: frontAdverb == null? this.frontAdverb : frontAdverb.value,
    subject: subject == null? this.subject : subject.value,
    modalVerb: modalVerb == null? this.modalVerb : modalVerb.value,
    midAdverb: midAdverb == null? this.midAdverb : midAdverb.value,
    verb: verb == null? this.verb : verb.value,
    indirectObject: indirectObject == null? this.indirectObject : indirectObject.value,
    directObject: directObject == null? this.directObject : directObject.value,
    subjectComplement: subjectComplement == null? this.subjectComplement : subjectComplement.value,
    endAdverb: endAdverb == null? this.endAdverb : endAdverb.value,
  );

  AnyAdverb get undefinedFrontAdverb => const UndefinedAdverb('<FrontAdverb>');
  AnyNoun get undefinedSubject => const UndefinedSubject();
  String get undefinedFirstAuxiliaryVerb => '<FirstAuxiliaryVerb>';
  String get undefinedSecondAuxiliaryVerb => '<SecondAuxiliaryVerb>';
  String get undefinedThirdAuxiliaryVerb => '<ThirdAuxiliaryVerb>';
  ModalVerb get undefinedModalVerb => const UndefinedModalVerb();
  AnyAdverb get undefinedMiddleAdverb => const UndefinedAdverb('<MiddleAdverb>');
  AnyVerb get undefinedVerb => const UndefinedVerb();
  IndirectObject get undefinedIndirectObject => const UndefinedIndirectObject();
  DirectObject get undefinedDirectObject => const UndefinedDirectObject();
  SubjectComplement get undefinedSubjectComplement => const UndefinedSubjectComplement();
  AnyAdverb get undefinedEndAdverb => const UndefinedAdverb('<EndAdverb>');

  AnyAdverb get safeFrontAdverb => frontAdverb ?? undefinedFrontAdverb;
  AnyNoun get safeSubject => subject ?? undefinedSubject;
  String? get firstAuxiliaryVerb => auxiliaries.firstOrNull;
  String? get secondAuxiliaryVerb => auxiliaries.elementAtOrNull(1);
  String? get thirdAuxiliaryVerb => auxiliaries.elementAtOrNull(2);
  ModalVerb get safeModalVerb => modalVerb ?? undefinedModalVerb;
  AnyAdverb get safeMiddleAdverb => midAdverb ?? undefinedMiddleAdverb;
  AnyVerb get safeVerb => verb ?? undefinedVerb;
  IndirectObject get safeIndirectObject => indirectObject ?? undefinedIndirectObject;
  DirectObject get safeDirectObject => directObject ?? undefinedDirectObject;
  SubjectComplement get safeSubjectComplement => subjectComplement ?? undefinedSubjectComplement;
  AnyAdverb get safeEndAdverb => endAdverb ?? undefinedEndAdverb;

  List<String?> get auxiliaries => switch(settings.tense) {
    Tense.simplePresent => simplePresentAuxiliaries(),
    Tense.simplePast => simplePastAuxiliaries(),
    Tense.simpleFuture => simpleFutureAuxiliaries(),
    Tense.simplePresentPerfect => simplePresentPerfectAuxiliaries(),
    Tense.simplePastPerfect => simplePastPerfectAuxiliaries(),
    Tense.simpleFuturePerfect => simpleFuturePerfectAuxiliaries(),
    Tense.continuousPresent => continuousPresentAuxiliaries(),
    Tense.continuousPast => continuousPastAuxiliaries(),
    Tense.continuousFuture => continuousFutureAuxiliaries(),
    Tense.continuousPresentPerfect => continuousPresentPerfectAuxiliaries(),
    Tense.continuousPastPerfect => continuousPastPerfectAuxiliaries(),
    _ => continuousFuturePerfectAuxiliaries(),
  };

  List<String?> simplePresentAuxiliaries() {
    bool contraction = !settings.isInterrogative && settings.contraction;
    String presentToBe = safeVerb.present(
      singularFirstPerson: safeSubject.isSingularFirstPerson,
      singularThirdPerson: safeSubject.isSingularThirdPerson,
      contraction: contraction,
      negativeContraction: settings.negativeContraction,
      negative: settings.isNegative,
    );
    List<String?> affirmative = [
      settings.modalVerb
          ? modalVerb?.affirmativeValue(contraction)
          : verb is Be
          ? presentToBe
          : settings.isInterrogative || settings.affirmativeEmphasis
          ? safeSubject.isSingularThirdPerson
          ? 'does'
          : 'do'
          : null
    ];
    List<String?> negative = [
      settings.modalVerb
          ? modalVerb?.negativeValue(settings.contraction, settings.negativeContraction)
          : verb is Be
          ? presentToBe
          : settings.negativeContraction
          ? safeSubject.isSingularThirdPerson
          ? "doesn't"
          : "don't"
          : safeSubject.isSingularThirdPerson
          ? 'does not'
          : 'do not'
    ];
    return settings.isNegative? negative : affirmative;
  }

  List<String?> simplePastAuxiliaries() {
    String pastBe = safeVerb.simplePast(
        isPlural: safeSubject.countability == Countability.singular,
        negativeContraction: settings.contraction,
        negative: settings.isNegative);
    List<String?> affirmative = [
      verb is Be
          ? pastBe
          : settings.isInterrogative || settings.affirmativeEmphasis
          ? 'did'
          : null
    ];
    List<String?> negative = [
      verb is Be
          ? pastBe
          : settings.negativeContraction
          ? "didn't"
          : 'did not'
    ];
    return settings.isNegative? negative : affirmative;
  }

  List<String?> simpleFutureAuxiliaries() {
    List<String?> affirmative = [
      settings.contraction && !settings.isInterrogative ? "'ll" : 'will'
    ];
    List<String?> negative = [
      settings.contraction? "'ll not" :
      settings.negativeContraction ? "won't" : 'will not'
    ];
    return settings.isNegative? negative : affirmative;
  }

  List<String?> simplePresentPerfectAuxiliaries() {
    List<String?> affirmative = [
      !settings.isInterrogative && settings.contraction
          ? safeSubject.isSingularThirdPerson
          ? "'s"
          : "'ve"
          : safeSubject.isSingularThirdPerson
          ? 'has'
          : 'have'
    ];
    List<String?> negative = [
      settings.contraction
          ? safeSubject.isSingularThirdPerson
          ? "'s not"
          : "'ve not"
          : settings.negativeContraction
          ? safeSubject.isSingularThirdPerson
          ? "hasn't"
          : "haven't"
          : safeSubject.isSingularThirdPerson
          ? 'has not'
          : 'have not'
    ];
    return settings.isNegative? negative : affirmative;
  }

  List<String?> simplePastPerfectAuxiliaries() {
    List<String?> affirmative = [
      !settings.isInterrogative && settings.contraction ? "'d" : "had"
    ];
    List<String?> negative = [
      settings.contraction ? "'d not" : "had not"
    ];
    return settings.isNegative? negative : affirmative;
  }

  List<String?> simpleFuturePerfectAuxiliaries() {
    List<String?> affirmative = [
      !settings.isInterrogative && settings.contraction ? "'ll" : 'will',
      'have'
    ];
    List<String?> negative = [
      settings.contraction ? "'ll not" :
      settings.negativeContraction ? "won't" : 'will not',
      'have'
    ];
    return settings.isNegative? negative : affirmative;
  }

  List<String?> continuousPresentAuxiliaries() {
    String presentToBe = Be().present(
      singularFirstPerson: safeSubject.isSingularFirstPerson,
      singularThirdPerson: safeSubject.isSingularThirdPerson,
      contraction: !settings.isInterrogative && settings.contraction,
      negativeContraction: settings.negativeContraction,
      negative: settings.isNegative,
    );
    List<String?> affirmative = [
      settings.modalVerb
          ? safeModalVerb.affirmativeValue(!settings.isInterrogative && settings.contraction)
          : presentToBe,
      if (settings.modalVerb) 'be'
    ];
    List<String?> negative = [
      settings.modalVerb
          ? safeModalVerb.negativeValue(settings.contraction, settings.negativeContraction)
          : presentToBe,
      if (settings.modalVerb) 'be'
    ];
    return settings.isNegative? negative : affirmative;
  }

  List<String?> continuousPastAuxiliaries() {
    return [
      Be().simplePast(
        isPlural: safeSubject.countability == Countability.plural,
        negativeContraction: settings.negativeContraction,
        negative: settings.isNegative,
      )
    ];
  }

  List<String?> continuousFutureAuxiliaries() {
    List<String?> affirmative = [
      !settings.isInterrogative && settings.contraction ? "'ll" : 'will', 'be'
    ];
    List<String?> negative = [
      settings.contraction? "'ll not"
          : settings.negativeContraction? "won't" : 'will not',
      'be'
    ];
    return settings.isNegative? negative : affirmative;
  }

  List<String?> continuousPresentPerfectAuxiliaries() {
    List<String?> affirmative = [
      !settings.isInterrogative && settings.contraction
          ? safeSubject.isSingularThirdPerson
          ? "'s"
          : "'ve"
          : safeSubject.isSingularThirdPerson
          ? 'has'
          : 'have',
      'been'
    ];
    List<String?> negative = [
      settings.contraction
          ? safeSubject.isSingularThirdPerson
          ? "'s not"
          : "'ve not"
          : settings.negativeContraction
          ? safeSubject.isSingularThirdPerson
          ? "hasn't"
          : "haven't"
          : safeSubject.isSingularThirdPerson
          ? 'has not'
          : 'have not',
      'been'
    ];
    return settings.isNegative? negative : affirmative;
  }

  List<String?> continuousPastPerfectAuxiliaries() {
    List<String?> affirmative = [
      !settings.isInterrogative && settings.contraction ? "'d" : "had", 'been'
    ];
    List<String?> negative = [
      settings.contraction
          ? "'d not" : settings.negativeContraction? "hadn't"
          : "had not", 'been'
    ];
    return settings.isNegative? negative : affirmative;
  }

  List<String?> continuousFuturePerfectAuxiliaries() {
    List<String?> affirmative = [
      !settings.isInterrogative && settings.contraction ? "'ll" : 'will',
      'have',
      'been'
    ];
    List<String?> negative = [
      settings.contraction
          ? "'ll not" : settings.negativeContraction? "won't": 'will not',
      'have',
      'been'
    ];
    return settings.isNegative? negative : affirmative;
  }

  bool get isModalVerbEditable => (settings.isSimplePresent
      || settings.isContinuousPresent) && settings.modalVerb;

  bool get isModalVerbAllowed => settings.isSimplePresent
      || settings.isContinuousPresent;

  bool get isEmphasisAllowed => switch(settings.tense) {
    Tense.simplePresent => settings.isAffirmative && !settings.modalVerb && verb is! Be,
    Tense.simplePast => settings.isAffirmative && verb is! Be,
    _ => false,
  };

  bool get isContractionAllowed {
    bool contraction = !settings.isInterrogative;
    return switch(settings.tense) {
      Tense.simplePresent => contraction && (settings.modalVerb || verb is Be),
      Tense.simplePast || Tense.continuousPast => false,
      _ => contraction,
    };
  }

  bool get isNegativeContractionAllowed => settings.isNegative;

  bool get isBeAuxiliary => switch(settings.tense) {
    Tense.simplePresent => !settings.modalVerb && verb is Be,
    Tense.simplePast => verb is Be,
    _ => false,
  };

  bool get isContractionActive {
    bool isContractionAllowed = !settings.isInterrogative && settings.contraction;
    return switch(settings.tense) {
      Tense.simplePresent => isContractionAllowed
          && (settings.modalVerb && safeModalVerb.hasContraction || isBeAuxiliary),
      Tense.continuousPresent => isContractionAllowed
          && (settings.modalVerb && safeModalVerb.hasContraction || isBeAuxiliary),
      Tense.simplePast || Tense.continuousPast => false,
      _ => isContractionAllowed,
    };
  }

  String get auxiliaryConfig => [
    if (settings.modalVerb) 'Modal Verb',
    if (settings.affirmativeEmphasis) 'Affirmative Emphasis',
    if (settings.contraction) 'Contraction',
    if (settings.negativeContraction) 'Negative Contraction',
  ].join(', ');
}
