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

class IndependentClauseOptions {
  bool enableAffirmativeEmphasis;
  bool enableContractions;
  bool enableSecondContractionToBe;
  bool enableModalVerb;
  bool enableDirectObject;
  ClauseType type;
  Tense tense;

  IndependentClauseOptions({
    this.enableAffirmativeEmphasis = false,
    this.enableContractions = true,
    this.enableSecondContractionToBe = false,
    this.enableModalVerb = false,
    this.enableDirectObject = false,
    this.type = ClauseType.affirmative,
    this.tense = Tense.simplePresent,
  });

  IndependentClauseOptions copyWith({
    bool? enableAffirmativeEmphasis,
    bool? enableContractions,
    bool? enableSecondContractionToBe,
    bool? enableModalVerb,
    bool? enableDirectObject,
    ClauseType? type,
    Tense? tense,
  }) => IndependentClauseOptions(
    enableAffirmativeEmphasis: enableAffirmativeEmphasis ?? this.enableAffirmativeEmphasis,
    enableContractions: enableContractions ?? this.enableContractions,
    enableSecondContractionToBe: enableSecondContractionToBe ?? this.enableSecondContractionToBe,
    enableModalVerb: enableModalVerb ?? this.enableModalVerb,
    enableDirectObject: enableDirectObject ?? this.enableDirectObject,
    type: type ?? this.type,
    tense: tense ?? this.tense,
  );
}

class IndependentClause {
  IndependentClauseOptions options;
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
    required this.options,
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
    IndependentClauseOptions? options,
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
    options: options ?? this.options,
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
    if (options.type == ClauseType.affirmative) {
      if (options.tense == Tense.simplePresent) {
        return options.enableModalVerb || (!validVerb.isBe && options.enableAffirmativeEmphasis)
            ? VerbTense.infinitive
            : VerbTense.present;
      } else if (options.tense == Tense.simplePast) {
        return !validVerb.isBe && options.enableAffirmativeEmphasis ? VerbTense.infinitive : VerbTense.past;
      }
    } else if (options.type == ClauseType.negative && options.tense == Tense.simplePresent) {
      return options.enableModalVerb || !validVerb.isBe ? VerbTense.infinitive : VerbTense.present;
    }
    if (options.tense == Tense.simplePresent) {
      return validVerb.isBe && options.enableModalVerb? VerbTense.infinitive : VerbTense.present;
    } else if (options.tense == Tense.simplePast) {
      return VerbTense.infinitive;
    } else if (options.tense == Tense.simpleFuture) {
      return VerbTense.infinitive;
    } else if (options.tense == Tense.simplePresentPerfect
        || options.tense == Tense.simplePastPerfect
        || options.tense == Tense.simpleFuturePerfect) {
      return VerbTense.pastParticiple;
    } else {
      return VerbTense.presentParticiple;
    }
  }

  bool get noSpaceBetweenSubjectAndAuxiliar {
    if (options.type == ClauseType.affirmative && options.tense == Tense.simplePresent) {
      return validVerb.isBe
          && !options.enableModalVerb
          && options.enableContractions;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.simplePast) {
      return false;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.simpleFuture){
      return options.enableContractions;
    } if (options.type == ClauseType.affirmative && options.tense == Tense.simplePresentPerfect) {
      return options.enableContractions;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.simplePastPerfect) {
      return options.enableContractions;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.simpleFuturePerfect){
      return options.enableContractions;
    } if (options.type == ClauseType.affirmative && options.tense == Tense.continuousPresent) {
      return !options.enableModalVerb && options.enableContractions;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.continuousPast) {
      return false;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.continuousFuture){
      return options.enableContractions;
    } if (options.type == ClauseType.affirmative && options.tense == Tense.continuousPresentPerfect) {
      return options.enableContractions;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.continuousPastPerfect) {
      return options.enableContractions;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.continuousFuturePerfect){
      return options.enableContractions;
    } else if (options.type == ClauseType.negative && options.tense == Tense.simplePresent) {
      return validVerb.isBe && !options.enableModalVerb && options.enableContractions;
    } else if (options.type == ClauseType.negative && options.tense == Tense.simplePast) {
      return validVerb.isBe && options.enableContractions;
    } else if (options.type == ClauseType.negative && options.tense == Tense.simpleFuture){
      return false;
    } if (options.type == ClauseType.negative && options.tense == Tense.simplePresentPerfect) {
      return false;
    } else if (options.type == ClauseType.negative && options.tense == Tense.simplePastPerfect) {
      return options.enableContractions;
    } else if (options.type == ClauseType.negative && options.tense == Tense.simpleFuturePerfect){
      return false;
    } if (options.type == ClauseType.negative && options.tense == Tense.continuousPresent) {
      return !options.enableModalVerb &&
          options.enableContractions &&
          !options.enableSecondContractionToBe;
    } else if (options.type == ClauseType.negative && options.tense == Tense.continuousPast) {
      return false;
    } else if (options.type == ClauseType.negative && options.tense == Tense.continuousFuture){
      return false;
    } if (options.type == ClauseType.negative && options.tense == Tense.continuousPresentPerfect) {
      return options.enableContractions;
    } else if (options.type == ClauseType.negative && options.tense == Tense.continuousPastPerfect) {
      return options.enableContractions;
    } else if (options.type == ClauseType.negative && options.tense == Tense.continuousFuturePerfect){
      return false;
    }
    return false;
  }

  List<String?> get affirmativeSimplePresentAuxiliars => [
    options.enableModalVerb
        ? validModalVerb.value
        : validVerb.isBe
        ? conjugateVerbWord(validVerb)
        : options.enableAffirmativeEmphasis
        ? validSubject.singularThirdPerson
        ? 'does'
        : 'do'
        : null
  ];

  List<String?> get affirmativeSimplePastAuxiliars => [
    validVerb.isBe
        ? simplePastVerb(validVerb)
        : options.enableAffirmativeEmphasis
        ? 'did'
        : null
  ];

  String simplePastVerb(Verb verb) {
    if (verb.isBe) {
      if (options.type == ClauseType.negative) {
        Verb.negativeSimplePastBe(validSubject, options.enableContractions);
      }
      Verb.simplePastBe(validSubject);
    }
    return verb.past;
  }

  List<String?> get affirmativeSimpleFutureAuxiliars => [
    options.enableContractions ? "'ll" : 'will'
  ];

  List<String?> get affirmativeSimplePresentPerfectAuxiliars => [
    options.enableContractions
        ? validSubject.singularThirdPerson
        ? "'s"
        : "'ve"
        : validSubject.singularThirdPerson
        ? 'has'
        : 'have'
  ];

  List<String?> get affirmativeSimplePastPerfectAuxiliars => [
    options.enableContractions ? "'d" : "had"
  ];

  List<String?> get affirmativeSimpleFuturePerfectAuxiliars => [
    options.enableContractions ? "'ll" : 'will',
    'have'
  ];

  List<String?> get affirmativeContinuousPresentAuxiliars => [
    options.enableModalVerb
        ? validModalVerb.value
        : Verb.simplePresentBe(validSubject, options.enableContractions),
    if (options.enableModalVerb && verbWord.isBe) 'be'
  ];

  List<String?> get affirmativeContinuousPastAuxiliars => [
    Verb.simplePastBe(validSubject)
  ];

  List<String?> get affirmativeContinuousFutureAuxiliars => [
    options.enableContractions ? "'ll" : 'will', 'be'
  ];

  List<String?> get affirmativeContinuousPresentPerfectAuxiliars => [
    options.enableContractions
        ? validSubject.singularThirdPerson
        ? "'s"
        : "'ve"
        : validSubject.singularThirdPerson
        ? 'has'
        : 'have',
    'been'
  ];

  List<String?> get affirmativeContinuousPastPerfectAuxiliars => [
    options.enableContractions ? "'d" : "had", 'been'
  ];

  List<String?> get affirmativeContinuousFuturePerfectAuxiliars => [
    options.enableContractions ? "'ll" : 'will',
    'have',
    'been'
  ];

  List<String?> get negativeSimplePresentAuxiliars => [
    options.enableModalVerb
        ? validModalVerb.negative(options.enableContractions)
        : validVerb.isBe
        ? conjugateVerbWord(verbWord)
        : options.enableContractions
        ? validSubject.singularThirdPerson
        ? "doesn't"
        : "don't"
        : validSubject.singularThirdPerson
        ? 'does not'
        : 'do not'
  ];

  List<String?> get negativeSimplePastAuxiliars => [
    validVerb.isBe
        ? Verb.negativeSimplePastBe(validSubject, options.enableContractions)
        : options.enableContractions
        ? "didn't"
        : 'did not'
  ];

  List<String?> get negativeSimpleFutureAuxiliars => [
    options.enableContractions ? "won't" : 'will not'
  ];

  List<String?> get negativeSimplePresentPerfectAuxiliars => [
    options.enableContractions
        ? validSubject.singularThirdPerson
        ? "hasn't"
        : "haven't"
        : validSubject.singularThirdPerson
        ? 'has not'
        : 'have not'
  ];

  List<String?> get negativeSimplePastPerfectAuxiliars => [
    options.enableContractions ? "'d not" : "had not"
  ];

  List<String?> get negativeSimpleFuturePerfectAuxiliars => [
    options.enableContractions ? "won't" : 'will not',
    'have'
  ];

  List<String?> get negativeContinuousPresentAuxiliars => [
    options.enableModalVerb
        ? validModalVerb.negative(options.enableContractions)
        : Verb.negativeSimplePresentBe(
        validSubject, options.enableContractions, options.enableSecondContractionToBe),
    if (options.enableModalVerb) 'be'
  ];

  List<String?> get negativeContinuousPastAuxiliars => [
    Verb.negativeSimplePastBe(validSubject, options.enableContractions)
  ];

  List<String?> get negativeContinuousFutureAuxiliars => [
    options.enableContractions ? "won't" : 'will not', 'be'
  ];

  List<String?> get negativeContinuousPresentPerfectAuxiliars => [
    options.enableContractions
        ? validSubject.singularThirdPerson
        ? "'s not"
        : "'ve not"
        : validSubject.singularThirdPerson
        ? 'has not'
        : 'have not',
    'been'
  ];

  List<String?> get negativeContinuousPastPerfectAuxiliars => [
    options.enableContractions ? "'d not" : "'had not", 'been'
  ];

  List<String?> get negativeContinuousFuturePerfectAuxiliars => [
    options.enableContractions ? "won't" : 'will not',
    validSubject.singularThirdPerson ? 'has' : 'have',
    'been'
  ];

  List<String?> get interrogativeSimplePresentAuxiliars => [
    options.enableModalVerb
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
    options.enableModalVerb ? validModalVerb.value : Verb.simplePresentBe(validSubject, false),
    if (options.enableModalVerb) 'be'
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
      return verb.present(validSubject, options.enableContractions, options.type == ClauseType.negative, options.enableSecondContractionToBe);
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
    if (options.type == ClauseType.affirmative && options.tense == Tense.simplePresent) {
      return affirmativeSimplePresentAuxiliars;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.simplePast) {
      return affirmativeSimplePastAuxiliars;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.simpleFuture){
      return affirmativeSimpleFutureAuxiliars;
    } if (options.type == ClauseType.affirmative && options.tense == Tense.simplePresentPerfect) {
      return affirmativeSimplePresentPerfectAuxiliars;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.simplePastPerfect) {
      return affirmativeSimplePastPerfectAuxiliars;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.simpleFuturePerfect){
      return affirmativeSimpleFuturePerfectAuxiliars;
    } if (options.type == ClauseType.affirmative && options.tense == Tense.continuousPresent) {
      return affirmativeContinuousPresentAuxiliars;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.continuousPast) {
      return affirmativeContinuousPastAuxiliars;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.continuousFuture){
      return affirmativeContinuousFutureAuxiliars;
    } if (options.type == ClauseType.affirmative && options.tense == Tense.continuousPresentPerfect) {
      return affirmativeContinuousPresentPerfectAuxiliars;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.continuousPastPerfect) {
      return affirmativeContinuousPastPerfectAuxiliars;
    } else if (options.type == ClauseType.affirmative && options.tense == Tense.continuousFuturePerfect){
      return affirmativeContinuousFuturePerfectAuxiliars;
    } else if (options.type == ClauseType.negative && options.tense == Tense.simplePresent) {
      return negativeSimplePresentAuxiliars;
    } else if (options.type == ClauseType.negative && options.tense == Tense.simplePast) {
      return negativeSimplePastAuxiliars;
    } else if (options.type == ClauseType.negative && options.tense == Tense.simpleFuture){
      return negativeSimpleFutureAuxiliars;
    } if (options.type == ClauseType.negative && options.tense == Tense.simplePresentPerfect) {
      return negativeSimplePresentPerfectAuxiliars;
    } else if (options.type == ClauseType.negative && options.tense == Tense.simplePastPerfect) {
      return negativeSimplePastPerfectAuxiliars;
    } else if (options.type == ClauseType.negative && options.tense == Tense.simpleFuturePerfect){
      return negativeSimpleFuturePerfectAuxiliars;
    } if (options.type == ClauseType.negative && options.tense == Tense.continuousPresent) {
      return negativeContinuousPresentAuxiliars;
    } else if (options.type == ClauseType.negative && options.tense == Tense.continuousPast) {
      return negativeContinuousPastAuxiliars;
    } else if (options.type == ClauseType.negative && options.tense == Tense.continuousFuture){
      return negativeContinuousFutureAuxiliars;
    } if (options.type == ClauseType.negative && options.tense == Tense.continuousPresentPerfect) {
      return negativeContinuousPresentPerfectAuxiliars;
    } else if (options.type == ClauseType.negative && options.tense == Tense.continuousPastPerfect) {
      return negativeContinuousPastPerfectAuxiliars;
    } else if (options.type == ClauseType.negative && options.tense == Tense.continuousFuturePerfect){
      return negativeContinuousFuturePerfectAuxiliars;
    } else if (options.type == ClauseType.interrogative && options.tense == Tense.simplePresent) {
      return interrogativeSimplePresentAuxiliars;
    } else if (options.type == ClauseType.interrogative && options.tense == Tense.simplePast) {
      return interrogativeSimplePastAuxiliars;
    } else if (options.type == ClauseType.interrogative && options.tense == Tense.simpleFuture){
      return interrogativeSimpleFutureAuxiliars;
    } if (options.type == ClauseType.interrogative && options.tense == Tense.simplePresentPerfect) {
      return interrogativeSimplePresentPerfectAuxiliars;
    } else if (options.type == ClauseType.interrogative && options.tense == Tense.simplePastPerfect) {
      return interrogativeSimplePastPerfectAuxiliars;
    } else if (options.type == ClauseType.interrogative && options.tense == Tense.simpleFuturePerfect){
      return interrogativeSimpleFuturePerfectAuxiliars;
    } if (options.type == ClauseType.interrogative && options.tense == Tense.continuousPresent) {
      return interrogativeContinuousPresentAuxiliars;
    } else if (options.type == ClauseType.interrogative && options.tense == Tense.continuousPast) {
      return interrogativeContinuousPastAuxiliars;
    } else if (options.type == ClauseType.interrogative && options.tense == Tense.continuousFuture){
      return interrogativeContinuousFutureAuxiliars;
    } if (options.type == ClauseType.interrogative && options.tense == Tense.continuousPresentPerfect) {
      return interrogativeContinuousPresentPerfectAuxiliars;
    } else if (options.type == ClauseType.interrogative && options.tense == Tense.continuousPastPerfect) {
      return interrogativeContinuousPastPerfectAuxiliars;
    }
    return interrogativeContinuousFuturePerfectAuxiliars;
  }

  @override
  String toString() {
    PhrasalVerbParticle? particle =
    verb is PhrasalVerb? (verb as PhrasalVerb).particle : null;
    Speech speech = Speech();
    speech.add(beginningAdverb);
    speech.add(',', when: beginningAdverb != null, disablePrefixWhen: true);
    speech.add(firstAuxiliar, when: options.type == ClauseType.interrogative);
    speech.add(validSubject);
    speech.add(firstAuxiliar,
        when: options.type != ClauseType.interrogative,
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
    speech.add('?', when: options.type == ClauseType.interrogative, disablePrefixWhen: true);
    return speech.toString();
  }
}
abstract class Predicate {
  List<Adverb> frontAdverbs;
  Adverb middleAdverb;
  List<Adverb> endAdverbs;

  Predicate({
    required this.frontAdverbs,
    required this.middleAdverb,
    required this.endAdverbs,
  });
}
class LinkPredicate extends Predicate {
  SubjectComplement subjectComplement;

  LinkPredicate({
    required super.frontAdverbs,
    required super.middleAdverb,
    required super.endAdverbs,
    required this.subjectComplement,
  });
}
class ActionPredicate extends Predicate {
  IndirectObject? indirectObject;
  DirectObject? directObject;

  ActionPredicate({
    required super.frontAdverbs,
    required super.middleAdverb,
    required super.endAdverbs,
    this.indirectObject,
    this.directObject,
  });
}
class VerbPhrase {
  // IndependentClauseOptions options;
  String firstAux;
  String secondAux;
  String thirdAux;
  Verb verb;

  VerbPhrase({
    // required this.options,
    required this.firstAux,
    required this.secondAux,
    required this.thirdAux,
    required this.verb,
  });
}
