import '../../util/speech.dart';
import '../adverb/adverb.dart';
import '../common/nullable.dart';
import '../noun/direct_object.dart';
import '../noun/empty_subject.dart';
import '../noun/indirect_object.dart';
import '../noun/noun_phrase.dart';
import '../noun/subject.dart';
import '../noun/pronoun.dart';
import '../noun/subject_type.dart';
import '../subject_complement.dart';
import '../tense.dart';
import '../tense_type.dart';
import '../verb/empty_modal_verb.dart';
import '../verb/modal_verb.dart';
import '../verb/empty_verb.dart';
import '../verb/phrasal_verb.dart';
import '../verb/phrasal_verb_particle.dart';
import '../verb/verb.dart';
import '../verb/verb_tense.dart';
import '../verb/verb_word.dart';
import '../verb/verb_phrase.dart';
import 'clause_type.dart';

class IndependentClause {
  bool enableAffirmativeEmphasis;
  bool enableContractions;
  bool enableSecondContractionToBe;
  bool enableModalVerb;
  bool enableDirectObject;
  ClauseType type;
  TenseType tenseType;
  Tense tense;
  Adverb? beginningAdverb;
  SubjectType subjectType;
  Subject? subject;
  ModalVerb? modalVerb;
  Adverb? midAdverb;
  Verb? verb;
  IndirectObject? indirectObject;
  DirectObject? directObject;
  List<Adverb> adverbs;
  SubjectComplement? subjectComplement;

  IndependentClause({
    this.enableAffirmativeEmphasis = false,
    this.enableContractions = true,
    this.enableSecondContractionToBe = false,
    this.enableModalVerb = false,
    this.enableDirectObject = false,
    required this.type,
    required this.tenseType,
    required this.tense,
    this.beginningAdverb,
    this.subjectType = SubjectType.pronoun,
    this.subject,
    this.modalVerb,
    this.midAdverb,
    this.verb,
    this.indirectObject,
    this.directObject,
    this.adverbs = const [],
    this.subjectComplement,
  });

  IndependentClause copyWith({
    bool? enableAffirmativeEmphasis,
    bool? enableContractions,
    bool? enableSecondContractionToBe,
    bool? enableModalVerb,
    bool? enableDirectObject,
    ClauseType? type,
    TenseType? tenseType,
    Tense? tense,
    Nullable<Adverb>? beginningAdverb,
    SubjectType? subjectType,
    Nullable<Subject>? subject,
    Nullable<ModalVerb>? modalVerb,
    Nullable<Adverb>? midAdverb,
    Nullable<Verb>? verb,
    Nullable<IndirectObject>? indirectObject,
    Nullable<DirectObject>? directObject,
    List<Adverb>? adverbs,
    Nullable<SubjectComplement>? subjectComplement,
  }) => IndependentClause(
    enableAffirmativeEmphasis: enableAffirmativeEmphasis ?? this.enableAffirmativeEmphasis,
    enableContractions: enableContractions ?? this.enableContractions,
    enableSecondContractionToBe: enableSecondContractionToBe ?? this.enableSecondContractionToBe,
    enableModalVerb: enableModalVerb ?? this.enableModalVerb,
    enableDirectObject: enableDirectObject ?? this.enableDirectObject,
    type: type ?? this.type,
    tenseType: tenseType ?? this.tenseType,
    tense: tense ?? this.tense,
    beginningAdverb: beginningAdverb == null? this.beginningAdverb : beginningAdverb.value,
    subjectType: subjectType ?? this.subjectType,
    subject: subject == null? this.subject : subject.value,
    modalVerb: modalVerb == null? this.modalVerb : modalVerb.value,
    midAdverb: midAdverb == null? this.midAdverb : midAdverb.value,
    verb: verb == null? this.verb : verb.value,
    indirectObject: indirectObject == null? this.indirectObject : indirectObject.value,
    directObject: directObject == null? this.directObject : directObject.value,
    adverbs: adverbs ?? this.adverbs,
    subjectComplement: subjectComplement == null? this.subjectComplement : subjectComplement.value,
  );

  Pronoun? get pronoun => subject is Pronoun? subject as Pronoun : null;
  NounPhrase? get nounPhrase => subject is NounPhrase? subject as NounPhrase : null;

  Verb get validVerb => verb ?? EmptyVerb();
  ModalVerb get validModalVerb => modalVerb ?? EmptyModalVerb();
  Subject get validSubject => subject ?? EmptySubject();
  Verb get verbWord => verb is PhrasalVerb? (verb as PhrasalVerb).verb : validVerb;

  VerbTense get verbTense {
    if (type == ClauseType.affirmative) {
      if (tense == Tense.simplePresent) {
        return enableModalVerb || (!validVerb.isBe && enableAffirmativeEmphasis)
            ? VerbTense.infinitive
            : VerbTense.present;
      } else if (tense == Tense.simplePast) {
        return !validVerb.isBe && enableAffirmativeEmphasis ? VerbTense.infinitive : VerbTense.past;
      }
    } else if (type == ClauseType.negative && tense == Tense.simplePresent) {
      return enableModalVerb || !validVerb.isBe ? VerbTense.infinitive : VerbTense.present;
    }
    if (tense == Tense.simplePresent) {
      return validVerb.isBe && enableModalVerb? VerbTense.infinitive : VerbTense.present;
    } else if (tense == Tense.simplePast) {
      return VerbTense.infinitive;
    } else if (tense == Tense.simpleFuture) {
      return VerbTense.infinitive;
    } else if (tense == Tense.simplePresentPerfect
        || tense == Tense.simplePastPerfect
        || tense == Tense.simpleFuturePerfect) {
      return VerbTense.pastParticiple;
    } else {
      return VerbTense.presentParticiple;
    }
  }

  bool get noSpaceBetweenSubjectAndAuxiliar {
    if (type == ClauseType.affirmative && tense == Tense.simplePresent) {
      return validVerb.isBe
          && !enableModalVerb
          && enableContractions;
    } else if (type == ClauseType.affirmative && tense == Tense.simplePast) {
      return false;
    } else if (type == ClauseType.affirmative && tense == Tense.simpleFuture){
      return enableContractions;
    } if (type == ClauseType.affirmative && tense == Tense.simplePresentPerfect) {
      return enableContractions;
    } else if (type == ClauseType.affirmative && tense == Tense.simplePastPerfect) {
      return enableContractions;
    } else if (type == ClauseType.affirmative && tense == Tense.simpleFuturePerfect){
      return enableContractions;
    } if (type == ClauseType.affirmative && tense == Tense.continuousPresent) {
      return !enableModalVerb && enableContractions;
    } else if (type == ClauseType.affirmative && tense == Tense.continuousPast) {
      return false;
    } else if (type == ClauseType.affirmative && tense == Tense.continuousFuture){
      return enableContractions;
    } if (type == ClauseType.affirmative && tense == Tense.continuousPresentPerfect) {
      return enableContractions;
    } else if (type == ClauseType.affirmative && tense == Tense.continuousPastPerfect) {
      return enableContractions;
    } else if (type == ClauseType.affirmative && tense == Tense.continuousFuturePerfect){
      return enableContractions;
    } else if (type == ClauseType.negative && tense == Tense.simplePresent) {
      return validVerb.isBe && !enableModalVerb && enableContractions;
    } else if (type == ClauseType.negative && tense == Tense.simplePast) {
      return validVerb.isBe && enableContractions;
    } else if (type == ClauseType.negative && tense == Tense.simpleFuture){
      return false;
    } if (type == ClauseType.negative && tense == Tense.simplePresentPerfect) {
      return false;
    } else if (type == ClauseType.negative && tense == Tense.simplePastPerfect) {
      return enableContractions;
    } else if (type == ClauseType.negative && tense == Tense.simpleFuturePerfect){
      return false;
    } if (type == ClauseType.negative && tense == Tense.continuousPresent) {
      return !enableModalVerb &&
          enableContractions &&
          !enableSecondContractionToBe;
    } else if (type == ClauseType.negative && tense == Tense.continuousPast) {
      return false;
    } else if (type == ClauseType.negative && tense == Tense.continuousFuture){
      return false;
    } if (type == ClauseType.negative && tense == Tense.continuousPresentPerfect) {
      return enableContractions;
    } else if (type == ClauseType.negative && tense == Tense.continuousPastPerfect) {
      return enableContractions;
    } else if (type == ClauseType.negative && tense == Tense.continuousFuturePerfect){
      return false;
    }
    return false;
  }

  List<String?> get affirmativeSimplePresentAuxiliars => [
    enableModalVerb
        ? validModalVerb.value
        : validVerb.isBe
        ? conjugateVerbWord(validVerb)
        : enableAffirmativeEmphasis
        ? validSubject.singularThirdPerson
        ? 'does'
        : 'do'
        : null
  ];

  List<String?> get affirmativeSimplePastAuxiliars => [
    validVerb.isBe
        ? simplePastVerb(validVerb)
        : enableAffirmativeEmphasis
        ? 'did'
        : null
  ];

  String simplePastVerb(Verb verb) {
    if (verb.isBe) {
      if (type == ClauseType.negative) {
        Verb.negativeSimplePastBe(validSubject, enableContractions);
      }
      Verb.simplePastBe(validSubject);
    }
    return verb.past;
  }

  List<String?> get affirmativeSimpleFutureAuxiliars => [
    enableContractions ? "'ll" : 'will'
  ];

  List<String?> get affirmativeSimplePresentPerfectAuxiliars => [
    enableContractions
        ? validSubject.singularThirdPerson
        ? "'s"
        : "'ve"
        : validSubject.singularThirdPerson
        ? 'has'
        : 'have'
  ];

  List<String?> get affirmativeSimplePastPerfectAuxiliars => [
    enableContractions ? "'d" : "had"
  ];

  List<String?> get affirmativeSimpleFuturePerfectAuxiliars => [
    enableContractions ? "'ll" : 'will',
    'have'
  ];

  List<String?> get affirmativeContinuousPresentAuxiliars => [
    enableModalVerb
        ? validModalVerb.value
        : Verb.simplePresentBe(validSubject, enableContractions),
    if (enableModalVerb && verbWord.isBe) 'be'
  ];

  List<String?> get affirmativeContinuousPastAuxiliars => [
    Verb.simplePastBe(validSubject)
  ];

  List<String?> get affirmativeContinuousFutureAuxiliars => [
    enableContractions ? "'ll" : 'will', 'be'
  ];

  List<String?> get affirmativeContinuousPresentPerfectAuxiliars => [
    enableContractions
        ? validSubject.singularThirdPerson
        ? "'s"
        : "'ve"
        : validSubject.singularThirdPerson
        ? 'has'
        : 'have',
    'been'
  ];

  List<String?> get affirmativeContinuousPastPerfectAuxiliars => [
    enableContractions ? "'d" : "had", 'been'
  ];

  List<String?> get affirmativeContinuousFuturePerfectAuxiliars => [
    enableContractions ? "'ll" : 'will',
    'have',
    'been'
  ];

  List<String?> get negativeSimplePresentAuxiliars => [
    enableModalVerb
        ? validModalVerb.negative(enableContractions)
        : validVerb.isBe
        ? conjugateVerbWord(verbWord)
        : enableContractions
        ? validSubject.singularThirdPerson
        ? "doesn't"
        : "don't"
        : validSubject.singularThirdPerson
        ? 'does not'
        : 'do not'
  ];

  List<String?> get negativeSimplePastAuxiliars => [
    validVerb.isBe
        ? Verb.negativeSimplePastBe(validSubject, enableContractions)
        : enableContractions
        ? "didn't"
        : 'did not'
  ];

  List<String?> get negativeSimpleFutureAuxiliars => [
    enableContractions ? "won't" : 'will not'
  ];

  List<String?> get negativeSimplePresentPerfectAuxiliars => [
    enableContractions
        ? validSubject.singularThirdPerson
        ? "hasn't"
        : "haven't"
        : validSubject.singularThirdPerson
        ? 'has not'
        : 'have not'
  ];

  List<String?> get negativeSimplePastPerfectAuxiliars => [
    enableContractions ? "'d not" : "had not"
  ];

  List<String?> get negativeSimpleFuturePerfectAuxiliars => [
    enableContractions ? "won't" : 'will not',
    'have'
  ];

  List<String?> get negativeContinuousPresentAuxiliars => [
    enableModalVerb
        ? validModalVerb.negative(enableContractions)
        : Verb.negativeSimplePresentBe(
        validSubject, enableContractions, enableSecondContractionToBe),
    if (enableModalVerb) 'be'
  ];

  List<String?> get negativeContinuousPastAuxiliars => [
    Verb.negativeSimplePastBe(validSubject, enableContractions)
  ];

  List<String?> get negativeContinuousFutureAuxiliars => [
    enableContractions ? "won't" : 'will not', 'be'
  ];

  List<String?> get negativeContinuousPresentPerfectAuxiliars => [
    enableContractions
        ? validSubject.singularThirdPerson
        ? "'s not"
        : "'ve not"
        : validSubject.singularThirdPerson
        ? 'has not'
        : 'have not',
    'been'
  ];

  List<String?> get negativeContinuousPastPerfectAuxiliars => [
    enableContractions ? "'d not" : "'had not", 'been'
  ];

  List<String?> get negativeContinuousFuturePerfectAuxiliars => [
    enableContractions ? "won't" : 'will not',
    validSubject.singularThirdPerson ? 'has' : 'have',
    'been'
  ];

  List<String?> get interrogativeSimplePresentAuxiliars => [
    enableModalVerb
        ? validModalVerb.value
        : validVerb.isBe
        ? Verb.simplePresentBe(validSubject, false)
        : validSubject.singularThirdPerson
        ? 'does'
        : 'do'
  ];

  List<String?> get interrogativeSimplePastAuxiliars => [
    validVerb.isBe ? Verb.simplePastBe(validSubject) : 'did'
  ];

  List<String?> get interrogativeSimpleFutureAuxiliars => ['will'];

  List<String?> get interrogativeSimplePresentPerfectAuxiliars => [
    validSubject.singularThirdPerson ? 'has' : 'have'
  ];

  List<String?> get interrogativeSimplePastPerfectAuxiliars => ["Had"];

  List<String?> get interrogativeSimpleFuturePerfectAuxiliars => [
    'Will', validSubject.singularThirdPerson ? 'has' : 'have'
  ];

  List<String?> get interrogativeContinuousPresentAuxiliars => [
    enableModalVerb ? validModalVerb.value : Verb.simplePresentBe(validSubject, false),
    if (enableModalVerb) 'be'
  ];

  List<String?> get interrogativeContinuousPastAuxiliars => [
    Verb.simplePastBe(validSubject)
  ];

  List<String?> get interrogativeContinuousFutureAuxiliars => ['will', 'be'];

  List<String?> get interrogativeContinuousPresentPerfectAuxiliars => [
    validSubject.singularThirdPerson ? 'has' : 'have', 'been'
  ];

  List<String?> get interrogativeContinuousPastPerfectAuxiliars => ["had", 'been'];

  List<String?> get interrogativeContinuousFuturePerfectAuxiliars => ['will', 'have', 'been'];
  
  bool get isFirstAuxiliarVerbContracted { return true; }
  String? get frontAdverbString { return beginningAdverb == null? '<Front Adverb>' : '$beginningAdverb'; }
  String get subjectString { return '$validSubject'; }
  String? get firstAuxiliar => auxiliars.first;
  String? get midAdverbString { return null; }
  String? get secondAuxiliar => auxiliars.elementAtOrNull(1);
  String? get thirdAuxiliar => auxiliars.elementAtOrNull(2);
  String get conjugatedVerbWord { return ''; }
  String get subjectComplementString { return subjectComplement == null? '<Subject Complement>' : '$subjectComplement'; }
  String get indirectObjectString { return indirectObject == null? '<Indirect Object>' : '$indirectObject'; }
  String get directObjectString { return directObject == null? '<Direct Object>' : '$directObject'; }
  String? get phrasalVerbParticle { return verb is PhrasalVerb? (verb as PhrasalVerb).particle.toString() : null; }
  List<String>? get adverbStrings { return null; }
  
  String conjugateVerbWord(Verb verb) {
    if (verbTense == VerbTense.present) {
      return verb.present(validSubject, enableContractions, type == ClauseType.negative, enableSecondContractionToBe);
    } if (verbTense == VerbTense.past) {
      return simplePastVerb(verb);
    } else if (verbTense == VerbTense.presentParticiple) {
      return verb.presentParticiple;
    } else if (verbTense == VerbTense.pastParticiple) {
      return verb.pastParticiple;
    }
    return verb.infinitive;
  }

  List<String?> get auxiliars {
    if (type == ClauseType.affirmative && tense == Tense.simplePresent) {
      return affirmativeSimplePresentAuxiliars;
    } else if (type == ClauseType.affirmative && tense == Tense.simplePast) {
      return affirmativeSimplePastAuxiliars;
    } else if (type == ClauseType.affirmative && tense == Tense.simpleFuture){
      return affirmativeSimpleFutureAuxiliars;
    } if (type == ClauseType.affirmative && tense == Tense.simplePresentPerfect) {
      return affirmativeSimplePresentPerfectAuxiliars;
    } else if (type == ClauseType.affirmative && tense == Tense.simplePastPerfect) {
      return affirmativeSimplePastPerfectAuxiliars;
    } else if (type == ClauseType.affirmative && tense == Tense.simpleFuturePerfect){
      return affirmativeSimpleFuturePerfectAuxiliars;
    } if (type == ClauseType.affirmative && tense == Tense.continuousPresent) {
      return affirmativeContinuousPresentAuxiliars;
    } else if (type == ClauseType.affirmative && tense == Tense.continuousPast) {
      return affirmativeContinuousPastAuxiliars;
    } else if (type == ClauseType.affirmative && tense == Tense.continuousFuture){
      return affirmativeContinuousFutureAuxiliars;
    } if (type == ClauseType.affirmative && tense == Tense.continuousPresentPerfect) {
      return affirmativeContinuousPresentPerfectAuxiliars;
    } else if (type == ClauseType.affirmative && tense == Tense.continuousPastPerfect) {
      return affirmativeContinuousPastPerfectAuxiliars;
    } else if (type == ClauseType.affirmative && tense == Tense.continuousFuturePerfect){
      return affirmativeContinuousFuturePerfectAuxiliars;
    } else if (type == ClauseType.negative && tense == Tense.simplePresent) {
      return negativeSimplePresentAuxiliars;
    } else if (type == ClauseType.negative && tense == Tense.simplePast) {
      return negativeSimplePastAuxiliars;
    } else if (type == ClauseType.negative && tense == Tense.simpleFuture){
      return negativeSimpleFutureAuxiliars;
    } if (type == ClauseType.negative && tense == Tense.simplePresentPerfect) {
      return negativeSimplePresentPerfectAuxiliars;
    } else if (type == ClauseType.negative && tense == Tense.simplePastPerfect) {
      return negativeSimplePastPerfectAuxiliars;
    } else if (type == ClauseType.negative && tense == Tense.simpleFuturePerfect){
      return negativeSimpleFuturePerfectAuxiliars;
    } if (type == ClauseType.negative && tense == Tense.continuousPresent) {
      return negativeContinuousPresentAuxiliars;
    } else if (type == ClauseType.negative && tense == Tense.continuousPast) {
      return negativeContinuousPastAuxiliars;
    } else if (type == ClauseType.negative && tense == Tense.continuousFuture){
      return negativeContinuousFutureAuxiliars;
    } if (type == ClauseType.negative && tense == Tense.continuousPresentPerfect) {
      return negativeContinuousPresentPerfectAuxiliars;
    } else if (type == ClauseType.negative && tense == Tense.continuousPastPerfect) {
      return negativeContinuousPastPerfectAuxiliars;
    } else if (type == ClauseType.negative && tense == Tense.continuousFuturePerfect){
      return negativeContinuousFuturePerfectAuxiliars;
    } else if (type == ClauseType.interrogative && tense == Tense.simplePresent) {
      return interrogativeSimplePresentAuxiliars;
    } else if (type == ClauseType.interrogative && tense == Tense.simplePast) {
      return interrogativeSimplePastAuxiliars;
    } else if (type == ClauseType.interrogative && tense == Tense.simpleFuture){
      return interrogativeSimpleFutureAuxiliars;
    } if (type == ClauseType.interrogative && tense == Tense.simplePresentPerfect) {
      return interrogativeSimplePresentPerfectAuxiliars;
    } else if (type == ClauseType.interrogative && tense == Tense.simplePastPerfect) {
      return interrogativeSimplePastPerfectAuxiliars;
    } else if (type == ClauseType.interrogative && tense == Tense.simpleFuturePerfect){
      return interrogativeSimpleFuturePerfectAuxiliars;
    } if (type == ClauseType.interrogative && tense == Tense.continuousPresent) {
      return interrogativeContinuousPresentAuxiliars;
    } else if (type == ClauseType.interrogative && tense == Tense.continuousPast) {
      return interrogativeContinuousPastAuxiliars;
    } else if (type == ClauseType.interrogative && tense == Tense.continuousFuture){
      return interrogativeContinuousFutureAuxiliars;
    } if (type == ClauseType.interrogative && tense == Tense.continuousPresentPerfect) {
      return interrogativeContinuousPresentPerfectAuxiliars;
    } else if (type == ClauseType.interrogative && tense == Tense.continuousPastPerfect) {
      return interrogativeContinuousPastPerfectAuxiliars;
    }
    return interrogativeContinuousFuturePerfectAuxiliars;
  }

  @override
  String toString() {
    PhrasalVerbParticle? particle =
    verb is PhrasalVerb? (verb as PhrasalVerb).particle : null;
    Speech speech = Speech();
    speech.add('$beginningAdverb,');
    speech.add(firstAuxiliar, when: type == ClauseType.interrogative);
    speech.add(validSubject);
    speech.add(firstAuxiliar,
        when: type != ClauseType.interrogative,
        disablePrefixWhen: noSpaceBetweenSubjectAndAuxiliar);
    speech.add(midAdverb);
    speech.add(secondAuxiliar);
    speech.add(thirdAuxiliar);
    speech.add(conjugateVerbWord(verbWord), when: !validVerb.isBe);
    speech.add(subjectComplement, when: validVerb.isLinkingVerb);
    speech.add(indirectObject, when: !validVerb.isLinkingVerb);
    speech.add(directObject, when: !validVerb.isLinkingVerb);
    speech.add(particle, when: !validVerb.isLinkingVerb);
    speech.add(adverbs.join(' '));
    speech.add('?', when: type == ClauseType.interrogative, disablePrefixWhen: true);
    return speech.toString();
  }
}
