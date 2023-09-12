import '../../nullable.dart';
import '../adverb/any_adverb.dart';
import '../adverb/undefined_adverb.dart';
import '../noun/direct_object.dart';
import '../noun/indirect_object.dart';
import '../noun/subject.dart';
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
  Subject? subject;
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

  AnyAdverb get safeFrontAdverb => frontAdverb ?? const UndefinedAdverb();
  Subject get safeSubject => subject ?? const UndefinedSubject();
  ModalVerb get safeModalVerb => modalVerb ?? const UndefinedModalVerb();
  AnyAdverb get safeMiddleAdverb => midAdverb ?? const UndefinedAdverb();
  AnyVerb get safeVerb => verb ?? const UndefinedVerb();
  IndirectObject get safeIndirectObject => indirectObject ?? const UndefinedIndirectObject();
  DirectObject get safeDirectObject => directObject ?? const UndefinedDirectObject();
  SubjectComplement get safeSubjectComplement => subjectComplement ?? const UndefinedSubjectComplement();
  AnyAdverb get safeEndAdverb => endAdverb ?? const UndefinedAdverb();

  IndependentClause copyWith({
    IndependentClauseSettings? settings,
    Nullable<AnyAdverb>? frontAdverb,
    Nullable<Subject>? subject,
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

  List<String?> get auxiliaries {
    return switch(settings.tense) {
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
      _ => continuousFuturePerfectAuxiliaries()
    };
  }

  List<String?> simplePresentAuxiliaries() {
    bool contraction = settings.isInterrogative? false
        : settings.contraction;
    String presentToBe = safeVerb.present(
      singularFirstPerson: safeSubject.singularFirstPerson,
      singularThirdPerson: safeSubject.singularThirdPerson,
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
          ? safeSubject.singularThirdPerson
          ? 'does'
          : 'do'
          : null
    ];
    List<String?> negative = [
      settings.modalVerb
          ? modalVerb?.negativeValue(settings.negativeContraction)
          : verb is Be
          ? presentToBe
          : settings.negativeContraction
          ? safeSubject.singularThirdPerson
          ? "doesn't"
          : "don't"
          : safeSubject.singularThirdPerson
          ? 'does not'
          : 'do not'
    ];
    return settings.isNegative? negative : affirmative;
  }

  List<String?> simplePastAuxiliaries() {
    String pastBe = safeVerb.simplePast(
        singular: safeSubject.singular,
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
      settings.negativeContraction ? "won't" : 'will not'
    ];
    return settings.isNegative? negative : affirmative;
  }

  List<String?> simplePresentPerfectAuxiliaries() {
    List<String?> affirmative = [
      !settings.isInterrogative && settings.contraction
          ? safeSubject.singularThirdPerson
          ? "'s"
          : "'ve"
          : safeSubject.singularThirdPerson
          ? 'has'
          : 'have'
    ];
    List<String?> negative = [
      settings.contraction
          ? safeSubject.singularThirdPerson
          ? "'s not"
          : "'ve not"
          : settings.negativeContraction
          ? safeSubject.singularThirdPerson
          ? "hasn't"
          : "haven't"
          : safeSubject.singularThirdPerson
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
      settings.negativeContraction ? "won't" : 'will not',
      'have'
    ];
    return settings.isNegative? negative : affirmative;
  }

  List<String?> continuousPresentAuxiliaries() {
    String presentToBe = Be().present(
      singularFirstPerson: safeSubject.singularFirstPerson,
      singularThirdPerson: safeSubject.singularThirdPerson,
      contraction: settings.contraction,
      negativeContraction: settings.negativeContraction,
      negative: settings.isNegative,
    );
    List<String?> affirmative = [
      settings.modalVerb
          ? safeModalVerb.affirmativeValue(settings.contraction)
          : presentToBe,
      if (settings.modalVerb) 'be'
    ];
    List<String?> negative = [
      settings.modalVerb
          ? safeModalVerb.negativeValue(settings.negativeContraction)
          : presentToBe,
      if (settings.modalVerb) 'be'
    ];
    return settings.isNegative? negative : affirmative;
  }

  List<String?> continuousPastAuxiliaries() {
    return [
      Be().simplePast(
        singular: safeSubject.singular,
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
          ? safeSubject.singularThirdPerson
          ? "'s"
          : "'ve"
          : safeSubject.singularThirdPerson
          ? 'has'
          : 'have',
      'been'
    ];
    List<String?> negative = [
      settings.contraction
          ? safeSubject.singularThirdPerson
          ? "'s not"
          : "'ve not"
          : settings.negativeContraction
          ? safeSubject.singularThirdPerson
          ? "hasn't"
          : "haven't"
          : safeSubject.singularThirdPerson
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
      settings.contraction ? "'ll not" : settings.negativeContraction? "won't": 'will not',
      'have',
      'been'
    ];
    return settings.isNegative? negative : affirmative;
  }

  bool get isBeAuxiliary => (settings.isSimplePresent || settings.isSimplePast)
      && verb is Be;
}
